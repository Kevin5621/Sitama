import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_magang/common/widgets/profile_header.dart';
import 'package:sistem_magang/common/widgets/setting_button.dart';
import 'package:sistem_magang/common/widgets/log_out_alert.dart';
import 'package:sistem_magang/common/widgets/reset_password.dart';
import 'package:sistem_magang/presenstation/student/profile/bloc/industry_bloc.dart';
import 'package:sistem_magang/presenstation/student/profile/bloc/industry_event.dart';
import 'package:sistem_magang/presenstation/student/profile/widgets/Industry_info.dart';
import 'package:sistem_magang/service_locator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 22),
            BlocProvider(
              create: (context) => sl<IndustryBloc>()..add(const FetchIndustryData()),
              child: const IndustryInfoWidget(),
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
