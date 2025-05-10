import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google Sign In
        _buildSocialButton(
          context: context,
          text: 'Continue with Google',
          icon: 'assets/images/google_logo.png',
          isAsset: true,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Google Sign In - Not implemented in this demo'),
                backgroundColor: AppTheme.info600,
              ),
            );
          },
        ),
        SizedBox(height: 16),

        // Facebook Sign In
        _buildSocialButton(
          context: context,
          text: 'Continue with Facebook',
          icon: 'assets/images/facebook_logo.png',
          isAsset: true,
          color: Color(0xFF1877F2),
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Facebook Sign In - Not implemented in this demo'),
                backgroundColor: AppTheme.info600,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String text,
    required String icon,
    required VoidCallback onPressed,
    bool isAsset = false,
    Color? color,
    Color? textColor,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor ?? AppTheme.neutral800,
        side: BorderSide(
          color: color != null ? color : AppTheme.neutral300,
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // For demo purposes, using icon instead of image asset
          isAsset
              ? icon.contains('google')
                  ? CustomIconWidget(
                      iconName:
                          'g_translate', // Using a Google-related icon as placeholder
                      color: Colors.red,
                    )
                  : CustomIconWidget(
                      iconName: 'facebook', // Using Facebook icon
                      color: Colors.white,
                    )
              : CustomIconWidget(
                  iconName: icon,
                  color: textColor ?? AppTheme.neutral800,
                ),
          SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}
