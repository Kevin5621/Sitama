import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_magang/common/widgets/profile_header.dart';
import 'package:sistem_magang/common/widgets/setting_button.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';
import 'package:sistem_magang/common/widgets/log_out_alert.dart';
import 'package:sistem_magang/common/widgets/reset_password.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(), // 
            SizedBox(height: 22),
            _industry(),
            SizedBox(height: 120),
            _settingsList(context),
          ],
        ),
      ),
    );
  }

  Padding _settingsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
                  return LogOutAlert();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Container _industry() {
    return Container(
      padding: EdgeInsets.all(20),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray500,
            offset: Offset(0, 2),
            blurRadius: 2,
          )
        ],
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Industri',
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Industri 1',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Nama : Pertamina',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Tanggal Mulai : 11 Agustus 2024',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Tanggal Selesai : 12 Agustus 2024',
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
