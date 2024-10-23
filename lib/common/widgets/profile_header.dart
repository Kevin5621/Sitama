import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_magang/common/widgets/profil%20header/cubit.dart';
import 'package:sistem_magang/common/widgets/profil%20header/model.dart';
import 'package:sistem_magang/common/widgets/profil%20header/states.dart';
import 'package:sistem_magang/core/config/assets/app_images.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';
import 'package:sistem_magang/core/service/secure_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_magang/service_locator.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        prefs: sl<SharedPreferences>(),
        apiClient: sl<SecureApiClient>(),
      )..loadProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.homePattern),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 45),
                  _buildPhotoProfile(context, state),
                  const SizedBox(height: 16),
                  _buildProfileInfo(state),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPhotoProfile(BuildContext context, ProfileState state) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.background),
            borderRadius: BorderRadius.circular(32),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: _buildProfileImage(state),
          ),
        ),
        if (state is! ProfileLoading)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: state is ProfileUploading
                    ? null
                    : () => context.read<ProfileCubit>().pickAndUploadImage(),
                icon: state is ProfileUploading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileImage(ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    String? photoUrl;
    if (state is ProfileLoaded) {
      photoUrl = state.profile.photoProfile;
    } else if (state is ProfileUploading) {
      photoUrl = state.currentProfile.photoProfile;
    }

    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: photoUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.photoProfile,
          fit: BoxFit.cover,
        ),
      );
    }
    
    return Image.asset(
      AppImages.photoProfile,
      fit: BoxFit.cover,
    );
  }

  Widget _buildProfileInfo(ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (state is ProfileError) {
      return Text(
        state.message,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      );
    }

    UserProfile? profile;
    if (state is ProfileLoaded) {
      profile = state.profile;
    } else if (state is ProfileUploading) {
      profile = state.currentProfile;
    }

    if (profile == null) return const SizedBox.shrink();

    return Column(
      children: [
        Text(
          profile.name ?? 'N/A',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          profile.username ?? 'N/A',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.gray,
          ),
        ),
        Text(
          profile.email ?? 'N/A',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }
}