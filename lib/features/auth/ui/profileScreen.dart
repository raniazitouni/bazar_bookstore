import 'dart:ui';

import 'package:bazar_bookstore/core/theme/app_colors.dart';
import 'package:bazar_bookstore/features/auth/controllers/auth_controller.dart';
import 'package:bazar_bookstore/features/auth/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userControllerProvider);
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(err.toString()),
            ),
          );
        },
        data: (session) {
          if (session == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.secondary,
                content: Text(
                  "Logout successful",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
            // Navigate to home
            Navigator.pushReplacementNamed(context, "/login");
          }
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),

      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Padding(
              padding: EdgeInsets.all(50),
              child: Text(
                "user not available ",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          final hasPicture = (user.pictureUrl?.isNotEmpty ?? false);

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 51,
                    backgroundColor: AppColors.secondary,
                    backgroundImage: hasPicture
                        ? NetworkImage(user.pictureUrl!)
                        : null,
                    child: !hasPicture
                        ? Icon(Icons.person, size: 51, color: AppColors.primary)
                        : null,
                  ),
                ),

                Column(
                  children: [
                    ProfileInfo(label: "Name", content: user.name),
                    const SizedBox(height: 30),

                    ProfileInfo(label: "Email", content: user.email),
                    const SizedBox(height: 30),

                    ProfileInfo(
                      label: "Phone Number",
                      content: user.phoneNumber,
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: authState.isLoading
                            ? null
                            : () {
                                ref
                                    .read(authControllerProvider.notifier)
                                    .signOut();
                              },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 40,
                          ),
                          backgroundColor: AppColors.gray50,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.5, color: Colors.red),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ],
            ),
          );
        },
        error: (err, stack) => Center(child: Text("Error: ${err.toString()}")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String label;
  final String content;

  const ProfileInfo({super.key, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.gray900,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.gray50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.gray200, width: 1.5),
          ),
          child: Text(
            content,
            style: TextStyle(
              color: AppColors.gray900,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
