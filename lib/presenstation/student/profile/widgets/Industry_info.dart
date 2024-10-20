import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';
import 'package:sistem_magang/data/models/industry_model.dart';
import 'package:sistem_magang/presenstation/student/profile/bloc/industry_bloc.dart';
import 'package:sistem_magang/presenstation/student/profile/bloc/industry_state.dart';

class IndustryInfoWidget extends StatelessWidget {
  const IndustryInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndustryBloc, IndustryState>(
      builder: (context, state) {
        if (state is IndustryInitial) {
          return const SizedBox.shrink();
        } else if (state is IndustryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is IndustryLoaded) {
          return _buildIndustryInfo(state.industry);
        } else if (state is IndustryEmpty) {
          return const Center(child: Text('Tidak ada data industri'));
        } else if (state is IndustryError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildIndustryInfo(IndustryModel industry) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
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
          const Center(
            child: Text(
              'Industri',
              style: TextStyle(
                color: AppColors.gray,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Nama: ${industry.name}',
            style: const TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Tanggal Mulai: ${_formatDate(industry.startDate)}',
            style: const TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Tanggal Selesai: ${_formatDate(industry.endDate)}',
            style: const TextStyle(
              color: AppColors.gray,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }
}