import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitama3/common/bloc/button/button_state.dart';
import 'package:sitama3/common/bloc/button/button_state_cubit.dart';
import 'package:sitama3/common/widgets/basic_app_button.dart';
import 'package:sitama3/core/config/theme/app_color.dart';
import 'package:sitama3/domain/usecases/log_out.dart';
import 'package:sitama3/routes.dart';
import 'package:sitama3/ui/Start/welcome/welcome.dart';

class LogOutAlert extends StatelessWidget {
  const LogOutAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ButtonStateCubit(),
      child: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WelcomePages()),
              (route) => false,
            );
          }
          if (state is ButtonFailurState) {
            print(state.errorMessage);
          }
        },
        child: Builder(
          builder: (context) => AlertDialog(
            content: Text(
              'Apakah anda yakin ingin meninggalkan akun ini ?',
            ),
            actions: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                  ),
                  child: Text(
                    'Cancel',
                  ),
                ),
              ),
              BasicAppButton(
                onPressed: () {
                  final buttonCubit =
                      BlocProvider.of<ButtonStateCubit>(context);
                  buttonCubit.excute(usecase: sl<LogoutUseCase>());
                },
                title: 'Log Out',
                height: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
