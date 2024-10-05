import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_state_cubit.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../config/assets/app_images.dart';
import '../common/welcome.dart';
import '../Mahasiswa/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.pattern), fit: BoxFit.cover)),
        ),
        Center(
          child: Image.asset(AppImages.logo),
        ),
      ]),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(
          create: (context) => AuthStateCubit()..appStarted(),
          child: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (context, state) {
              if(state is Authenticated){
                return HomePage();
              }
              if(state is UnAuthenticated){
                return WelcomePages();
              }
              return Container();
            }
          ),
        ),
      ),
    );
  }
}
