import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitama3/common/bloc/button/button_state.dart';
import 'package:sitama3/common/bloc/button/button_state_cubit.dart';
import 'package:sitama3/core/config/theme/app_color.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool height;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.height = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
        builder: (context, state) {
      if (state is ButtonLoadingState) {
        return _loading();
      }
      return _initialButton();
    });
  }

  Widget _loading() {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        minimumSize: height ? Size.fromHeight(65) : null,
      ),
      child: CircularProgressIndicator(),
    );
  }

  Widget _initialButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        minimumSize: height ? Size.fromHeight(65) : null,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
