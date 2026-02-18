import 'package:flutter/material.dart';
import 'package:ifriend_app/core/constants/strings.dart';
import 'package:ifriend_app/core/helpers/extensions.dart';
import 'package:ifriend_app/core/routing/routes.dart';
import 'package:ifriend_app/core/theme/color_manager.dart';
import 'package:ifriend_app/core/theme/styles_manager.dart';
import 'package:ifriend_app/core/widgets/custom_button.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final List<bool> _enabled = [true, true, true];

  Widget _buildPolicyItem(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.baseWhite.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lorem Ipsum is simply',
                style: TextStyles.font18White500Weight.copyWith(
                  color: ColorsManager.baseBlack,
                ),
              ),
              Switch(
                activeThumbColor: ColorsManager.baseWhite,
                activeTrackColor: ColorsManager.back,
                value: _enabled[index],
                onChanged: (v) => setState(() => _enabled[index] = v),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
            style: TextStyles.font14Grey500Weight.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.privacyPolicy),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            children: [
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
                style: TextStyles.font14Grey500Weight.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 18),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildPolicyItem(0),
                      _buildPolicyItem(1),
                      _buildPolicyItem(2),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: AppStrings.rejectAll,
                      outline: true,
                      backgroundColor: ColorsManager.primary,

                      radius: 16,
                      height: 55,
                      textStyle: TextStyles.font18White500Weight.copyWith(
                        color: ColorsManager.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          for (var i = 0; i < _enabled.length; i++) {
                            _enabled[i] = false;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      label: AppStrings.iAgree,
                      outline: false,
                      textStyle: TextStyles.font18White500Weight,
                      radius: 16,
                      height: 55,
                      onPressed: () {
                        final allAccepted = _enabled.every((e) => e);
                        if (allAccepted) {
                          context.pushNamed(
                            Routes.stepsToLinkWithChildDeviceScreen,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please agree to the terms to proceed',
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
