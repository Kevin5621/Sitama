import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sistem_magang/common/widgets/log_out_alert.dart';
import 'package:sistem_magang/common/widgets/profile_header.dart';
import 'package:sistem_magang/common/widgets/reset_password.dart';
import 'package:sistem_magang/common/widgets/setting_button.dart';
import 'package:sistem_magang/data/models/industry_box_student.dart';
import 'package:sistem_magang/data/source/industry_api_service.dart';
import 'package:sistem_magang/presenstation/student/profile/widgets/box_industry.dart';

import 'package:sistem_magang/service_locator.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key}) {
    // Memastikan service sudah diregister
    if (!sl.isRegistered<IndustryApiService>()) {
      sl.registerLazySingleton<IndustryApiService>(
          () => IndustryApiServiceImpl());
    }
  }

  final IndustryApiService _apiService = sl<IndustryApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 22),
            FutureBuilder<Either<String, InternshipModel>>(
              future: _apiService.getStudentProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const IndustryCard(internship: null);
                }

                if (snapshot.hasData) {
                  return snapshot.data!.fold(
                    (error) {
                      // Gunakan addPostFrameCallback untuk menampilkan SnackBar
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error)),
                        );
                      });
                      return const IndustryCard(internship: null);
                    },
                    (internship) => IndustryCard(internship: internship),
                  );
                }

                return const IndustryCard(internship: null);
              },
            ),
            const SizedBox(height: 120),
            _settingsList(context),
          ],
        ),
      ),
    );
  }

  Padding _settingsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SettingButton(
            icon: Icons.lock_reset,
            title: 'Reset Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ResetPasswordPage()),
              );
            },
          ),
          SettingButton(
            icon: Icons.logout,
            title: 'Log Out',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const LogOutAlert();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
