import 'package:flutter/material.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:gap/gap.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Privacy and Policy'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Privacy and Policy",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const Gap(20),
              const Text(
                "By using Blood Bridge, you agree to comply with these terms and conditions. Please read them carefully before proceeding.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
              const Gap(20),
              _buildSection(
                title: "1. Account Creation",
                content:
                    "To use Blood Bridge, you must create an account by providing accurate information. Users are responsible for maintaining the confidentiality of their login credentials.",
              ),
              _buildSection(
                title: "2. Use of Services",
                content:
                    "Blood Bridge connects users in need of blood with potential donors. All interactions should be respectful and in accordance with the mission of the app. Any misuse of the service may result in the termination of your account.",
              ),
              _buildSection(
                title: "3. Content and Health Tips",
                content:
                    "Health tips provided on Blood Bridge are for informational purposes only and should not be considered medical advice. Users should consult healthcare professionals for specific health concerns.",
              ),
              _buildSection(
                title: "4. Limitation of Liability",
                content:
                    "Blood Bridge does not guarantee the availability of blood donors or that donations will be fulfilled. The app is a platform for connecting users but is not responsible for any actions of users, including donations or communications outside the app.",
              ),
              _buildSection(
                title: "5. Changes to Terms",
                content:
                    "We reserve the right to modify these Terms and Conditions at any time. Changes will be posted within the app, and continued use of the app constitutes acceptance of the updated terms.",
              ),
              _buildSection(
                title: "6. Termination of Account",
                content:
                    "Blood Bridge may suspend or terminate accounts that violate these terms, misuse the platform, or engage in fraudulent or inappropriate activity.",
              ),
              _buildSection(
                title: "7. Contact Us",
                content:
                    "If you have any questions about these Terms and Conditions, please contact us at [Contact Email].",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        const Gap(8),
        Text(
          content,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        const Gap(20),
      ],
    );
  }
}
