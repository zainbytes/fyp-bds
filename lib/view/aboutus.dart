// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fyp/view/mywidgets/homepage/customappbar.dart';
import 'package:gap/gap.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'About us'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Corrected padding value
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alignment fix
            children: [
              const Text(
                "Our Vision and Mission",
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 16, 12, 0),
                ),
              ),
              const Gap(10),
              const Text(
                "Our vision is to become the leading connection for diagnosing and treating patients in the region, regardless of their ability to pay, and to be the foremost center for research into the causes and treatments of conditions affecting our community.",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const Gap(10),
              const Text(
                "Our mission is to serve as a model for alleviating patient suffering by applying modern curative methods, regardless of their ability to pay. We are dedicated to educating healthcare professionals and the public while conducting research into the causes and treatment of various blood-related needs.",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const Gap(30),
              const Text(
                "This app is developed by the students of GCU from computer science department as their final year project ,under the supervision of Dr Arbish Akram",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const Gap(16),
              // First Row: One Box
              ProfileCard(
                imageUrl: 'assets/images/female.jpg',
                name: 'Dr.Arbish Akram',
                description:
                    'PhD Computer Science , University of the Punjab, Lahore, Pakistan',
              ),
              const SizedBox(height: 16),
              // Second Row: Two Boxes
              Row(
                children: [
                  Expanded(
                    child: ProfileCard(
                      imageUrl: 'assets/images/zain.jpg',
                      name: 'Zain Ali',
                      description: 'Bs Computer Science , GCU Lahore, Pakistan',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProfileCard(
                      imageUrl:
                          'assets/images/Azlan.jpg',
                      name: 'Azlan Zeerak',
                      description: 'Bs Computer Science , GCU Lahore, Pakistan',
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

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;

  const ProfileCard({
    required this.imageUrl,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
