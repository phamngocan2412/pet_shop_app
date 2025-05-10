import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class LoginFormWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback togglePasswordVisibility;

  const LoginFormWidget({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.togglePasswordVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email Field
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: CustomIconWidget(
              iconName: 'email',
              color: AppTheme.neutral600,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }

            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email address';
            }

            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        SizedBox(height: 16),

        // Password Field
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: CustomIconWidget(
              iconName: 'lock',
              color: AppTheme.neutral600,
            ),
            suffixIcon: IconButton(
              icon: CustomIconWidget(
                iconName: obscurePassword ? 'visibility_off' : 'visibility',
                color: AppTheme.neutral600,
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
          obscureText: obscurePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }

            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }

            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
