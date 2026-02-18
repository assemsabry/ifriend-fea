import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';

enum UserRole { parent, child }

class UserRoleScreen extends StatefulWidget {
  static const routeName = '/user-role';
  final void Function(UserRole role)? onRoleSelected;

  const UserRoleScreen({super.key, this.onRoleSelected});

  @override
  State<UserRoleScreen> createState() => _UserRoleScreenState();
}

class _UserRoleScreenState extends State<UserRoleScreen> {
  UserRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              Text(
                "Who’s using the device?",
                style: TextStyles.font26Black600Weight,
              ),
              SizedBox(height: 8.h),
              Text(
                "Choose your role to continue — Parent or Child.",
                style: TextStyles.font15Grey400Weight,
              ),
              SizedBox(height: 28.h),
              RoleCard(
                selected: _selectedRole == UserRole.parent,
                title: "I’m a Parent",
                description:
                    "Set screen limits, monitor activity, and keep your child safe online.",
                imagePath: 'assets/images/parent.png',
                onTap: () {
                  setState(() => _selectedRole = UserRole.parent);
                },
              ),
              SizedBox(height: 16.h),
              RoleCard(
                selected: _selectedRole == UserRole.child,
                title: "I’m a Child",
                description:
                    "Play, learn, and use your apps safely — with your parent’s guidance.",
                imagePath: 'assets/images/child.png',
                onTap: () {
                  setState(() => _selectedRole = UserRole.child);
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _selectedRole == null
                      ? null
                      : () {
                          if (widget.onRoleSelected != null) {
                            widget.onRoleSelected!(_selectedRole!);
                            return;
                          }

                          // Both Parent and Child go to LoginScreen with their selected role
                          final roleString = _selectedRole == UserRole.parent
                              ? 'PARENT'
                              : 'CHILD';
                          Navigator.of(context).pushReplacementNamed(
                            Routes.loginScreen,
                            arguments: roleString,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D6EFF),
                    disabledBackgroundColor: const Color(
                      0xFF0D6EFF,
                    ).withValues(alpha: 0.4),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final bool selected;
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.selected,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20.r);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: selected
            ? const LinearGradient(
                colors: [Color(0xFF3C8BFF), Color(0xFF0062FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: selected ? null : Colors.white,
        border: selected
            ? null
            : Border.all(color: const Color(0xFFE1E3EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 72.h,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      imagePath,
                      height: 64.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : const Color(0xFF13151A),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: selected
                        ? Colors.white.withValues(alpha: 0.85)
                        : const Color(0xFF8A8D96),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
