import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/button/button_state.dart';
import '../../bloc/button/button_state_cubit.dart';
import '../../../config/theme/theme.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
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
        backgroundColor: AppTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        minimumSize: Size.fromHeight(65),
      ),
      child: CircularProgressIndicator(),
    );
  }

  Widget _initialButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(55),
        ),
        minimumSize: Size.fromHeight(65),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
