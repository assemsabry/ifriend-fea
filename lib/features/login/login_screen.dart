import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ifriend_app/core/di/injection.dart';
import 'package:ifriend_app/core/helpers/auth_local_datasource.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:ifriend_app/features/login/presentation/bloc/login_event.dart';
import 'package:ifriend_app/features/login/presentation/bloc/login_state.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/features/user_role/user_role_screen.dart';

class LoginScreen extends StatelessWidget {
  final String?
  initialRole; // 'PARENT' or 'CHILD' when provided from UserRoleScreen

  const LoginScreen({super.key, this.initialRole});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        loginWithGoogleUseCase: sl(),
        loginWithFacebookUseCase: sl(),
        registerDeviceUseCase: sl(),
      ),
      child: _LoginScreenContent(initialRole: initialRole),
    );
  }
}

class _LoginScreenContent extends StatefulWidget {
  final String? initialRole;

  const _LoginScreenContent({this.initialRole});

  @override
  State<_LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<_LoginScreenContent> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '585059466120-2951glj4es6272qjlt335mgvlkjena3f.apps.googleusercontent.com',
  );

  String? _pendingGoogleToken;
  String? _pendingFacebookToken;
  String? _selectedRole; // store role chosen by user in UserRoleScreen

  @override
  void initState() {
    super.initState();
    // If navigated from UserRoleScreen, use its selection and don't ask again
    if (widget.initialRole != null && widget.initialRole!.isNotEmpty) {
      _selectedRole = widget.initialRole;
    }
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return;

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken != null) {
        setState(() => _pendingGoogleToken = idToken);
        _navigateToRoleSelection(isGoogle: true);
      }
    } catch (e) {
      _showError('Google Sign-In failed: $e');
    }
  }

  Future<void> _handleFacebookSignIn() async {
    try {
      final result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken?.tokenString;
        if (accessToken != null) {
          setState(() => _pendingFacebookToken = accessToken);
          _navigateToRoleSelection(isGoogle: false);
        }
      } else {
        _showError('Facebook Sign-In failed');
      }
    } catch (e) {
      _showError('Facebook Sign-In failed: ${e.toString()}');
    }
  }

  void _navigateToRoleSelection({required bool isGoogle}) {
    final loginBloc = context.read<LoginBloc>();

    // If we already have a selected role (from initialRole), directly proceed with login
    if (_selectedRole != null && _selectedRole!.isNotEmpty) {
      final roleString = _selectedRole!;
      if (isGoogle && _pendingGoogleToken != null) {
        loginBloc.add(
          LoginWithGoogleEvent(idToken: _pendingGoogleToken!, role: roleString),
        );
      } else if (!isGoogle && _pendingFacebookToken != null) {
        loginBloc.add(
          LoginWithFacebookEvent(
            accessToken: _pendingFacebookToken!,
            role: roleString,
          ),
        );
      }

      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: loginBloc,
          child: UserRoleScreen(
            onRoleSelected: (role) {
              final roleString = role == UserRole.parent ? 'PARENT' : 'CHILD';
              // save user's selection locally — prefer this over API's user.role
              setState(() => _selectedRole = roleString);

              if (isGoogle && _pendingGoogleToken != null) {
                loginBloc.add(
                  LoginWithGoogleEvent(
                    idToken: _pendingGoogleToken!,
                    role: roleString,
                  ),
                );
              } else if (!isGoogle && _pendingFacebookToken != null) {
                loginBloc.add(
                  LoginWithFacebookEvent(
                    accessToken: _pendingFacebookToken!,
                    role: roleString,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            final authDataSource = sl<AuthLocalDataSource>();
            // Prefer the locally selected role; fallback to API value
            final finalRole = _selectedRole ?? state.loginData.user.role;

            await authDataSource.saveAuthData(
              accessToken: state.loginData.accessToken,
              refreshToken: state.loginData.refreshToken,
              userId: state.loginData.user.id,
              email: state.loginData.user.email,
              firstName: state.loginData.user.firstName,
              lastName: state.loginData.user.lastName,
              role: finalRole,
              profilePicture: state.loginData.user.profilePicture,
            );

            // Persist whether profile was completed according to API
            await authDataSource.setProfileCompleted(
              state.loginData.user.profileCompleted,
            );

            if (!context.mounted) return;

            context.read<LoginBloc>().add(RegisterDeviceEvent());

            final user = state.loginData.user;

            if (finalRole == "PARENT") {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.completeProfileScreen,
                arguments: user,
                (route) => false,
              );
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.setupChildProfileScreen,
                (route) => false,
              );
            }
          } else if (state is LoginError) {
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsManager.primary, ColorsManager.primary700],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildTopSection(),
                      Expanded(child: _buildCenterIllustration(isLoading)),
                      _buildBottomCard(context, isLoading),
                    ],
                  ),
                  if (isLoading) _buildLoadingOverlay(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(Routes.userRoleScreen);
          },
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: const BoxDecoration(
              color: ColorsManager.back,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterIllustration(bool isLoading) {
    return Center(
      child: Opacity(
        opacity: isLoading ? 0.5 : 1.0,
        child: Image.asset(
          'assets/images/login.png',
          width: 280.w,
          height: 280.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildBottomCard(BuildContext context, bool isLoading) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 12.h),
            _buildDescription(),
            SizedBox(height: 32.h),
            _buildGoogleButton(context, isLoading),
            SizedBox(height: 16.h),
            _buildFacebookButton(context, isLoading),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        style: TextStyles.font32Black600Weight,
        children: [
          const TextSpan(text: 'Welcome\nto '),
          TextSpan(
            text: 'I Friend',
            style: TextStyle(
              color: const Color(0xFF2196F3),
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: ' control !'),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'Start your journey in protecting and monitoring your child with ease and intelligence.',
      style: TextStyles.font14Grey500Weight,
      maxLines: 3,
    );
  }

  Widget _buildGoogleButton(BuildContext context, bool isLoading) {
    return _SocialLoginButton(
      onPressed: isLoading ? null : _handleGoogleSignIn,
      backgroundColor: ColorsManager.primary,
      icon: Image.asset("assets/images/google.png"),
      text: 'Login With Google',
      isEnabled: !isLoading,
    );
  }

  Widget _buildFacebookButton(BuildContext context, bool isLoading) {
    return _SocialLoginButton(
      onPressed: isLoading ? null : _handleFacebookSignIn,
      backgroundColor: ColorsManager.primary,
      icon: Image.asset("assets/images/facebook.png"),
      text: 'Login With Facebook',
      isEnabled: !isLoading,
    );
  }

  Widget _buildLoadingOverlay() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Widget icon;
  final String text;
  final bool isEnabled;

  const _SocialLoginButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.icon,
    required this.text,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(child: icon),
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(width: 32.w),
          ],
        ),
      ),
    );
  }
}
