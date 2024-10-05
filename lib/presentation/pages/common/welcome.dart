import 'package:flutter/material.dart';
import '../../../config/assets/app_images.dart';
import '../../../config/assets/app_vectors.dart';
import '../../../config/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common/login.dart';

class WelcomePages extends StatelessWidget {
  const WelcomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AppImages.pattern),
            fit: BoxFit.cover,
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.logo),
              SizedBox(height: 10),
              Text(
                'SITAMA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Selamat Datang di SITAMA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Bantu kegiatan magang dan bimbingan jadi lebih mudah!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.gray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 70),
              _loginButton(context),
              SizedBox(height: 16),
              Text(
                'Or continue with',
                style: TextStyle(
                  color: AppTheme.gray,
                ),
              ),
              SizedBox(height: 16),
              _signInWithGoogleButton(),
            ],
          ),
        ),
      ]),
    );
  }

  ElevatedButton _loginButton(context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        minimumSize: Size.fromHeight(50),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          color: AppTheme.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  OutlinedButton _signInWithGoogleButton() {
    return OutlinedButton(
      onPressed: () {
        // TODO: Google Sign
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppTheme.gray),
        minimumSize: const Size(324, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppVectors.google),
          SizedBox(width: 10),
          Text(
            'Lanjut Dengan Google',
            style: TextStyle(
              color: AppTheme.gray,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
