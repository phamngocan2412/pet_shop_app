import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../../theme/app_theme.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const TermsCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primary600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I agree to the ',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: AppTheme.primary700,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _showTermsDialog(context, 'Terms of Service');
                    },
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: AppTheme.primary700,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _showTermsDialog(context, 'Privacy Policy');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showTermsDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(
            title == 'Terms of Service'
                ? _getTermsOfServiceText()
                : _getPrivacyPolicyText(),
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  String _getTermsOfServiceText() {
    return '''These Terms of Service ("Terms") govern your access to and use of the Pet Shop application. By using our services, you agree to be bound by these Terms.

1. ACCOUNT REGISTRATION
You must register for an account to access certain features of our services. You agree to provide accurate information and keep it updated.

2. ACCEPTABLE USE
You agree not to engage in any of the following prohibited activities: (i) copying, distributing, or disclosing any part of the service; (ii) using any automated system to access the service; (iii) transmitting any viruses or harmful code; (iv) interfering with the proper working of the service.

3. USER CONTENT
Our service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material. You are responsible for the content you post.

4. TERMINATION
We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.

5. LIMITATION OF LIABILITY
In no event shall Pet Shop, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages.

6. CHANGES
We reserve the right, at our sole discretion, to modify or replace these Terms at any time.''';
  }

  String _getPrivacyPolicyText() {
    return '''This Privacy Policy describes how your personal information is collected, used, and shared when you use the Pet Shop application.

1. PERSONAL INFORMATION WE COLLECT
When you register, we collect information you provide to us such as your name, email address, and password.

2. HOW WE USE YOUR PERSONAL INFORMATION
We use the information we collect to: (i) provide, operate, and maintain our services; (ii) improve and personalize your experience; (iii) understand and analyze how you use our services; (iv) develop new products, services, features, and functionality; (v) communicate with you for customer service, updates, and marketing purposes.

3. SHARING YOUR PERSONAL INFORMATION
We do not share your personal information with third parties except as described in this Privacy Policy.

4. DATA RETENTION
We will maintain your information for as long as needed to provide you services or as required by applicable laws.

5. CHANGES
We may update this privacy policy from time to time in order to reflect changes to our practices or for other operational, legal or regulatory reasons.

6. CONTACT US
For more information about our privacy practices, if you have questions, or if you would like to make a complaint, please contact us by e-mail at privacy@petshop.com.''';
  }
}
