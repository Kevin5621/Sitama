// Cubit
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_magang/common/widgets/profil%20header/model.dart';
import 'package:sistem_magang/common/widgets/profil%20header/states.dart';
import 'package:sistem_magang/core/constansts/api_urls.dart';
import 'package:sistem_magang/core/service/secure_api.dart';
import 'package:sistem_magang/core/service/security_utils.dart';
import 'package:sistem_magang/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SharedPreferences _prefs;
  late SecureApiClient _apiClient;
  final ImagePicker _picker = ImagePicker();

  ProfileCubit({
    required SharedPreferences prefs,
    required SecureApiClient apiClient,
  }) : _prefs = prefs,
       _apiClient = apiClient,
       super(ProfileInitial()) {
    _initializeApiClient();
  }

  void _initializeApiClient() {
    final token = _prefs.getString('token') ?? '';
    
    // Update secret key if token changes
    if (_apiClient.secretKey != token) {
      // Instead of unregister and register, create a new instance
      _apiClient = SecureApiClient(
        baseUrl: ApiUrls.baseUrl,
        secretKey: token,
      );
      
      // Update the singleton in GetIt
      if (sl.isRegistered<SecureApiClient>()) {
        sl.unregister<SecureApiClient>();
      }
      sl.registerSingleton<SecureApiClient>(_apiClient);
    }
  }

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      _initializeApiClient(); // Refresh token if needed
      final response = await _apiClient.get(ApiUrls.studentProfile);
      
      if (response.statusCode == 200) {
        final responseData = response.data['data'] as Map<String, dynamic>;
        final validatedData = _validateProfileData(responseData);
        final profile = UserProfile.fromJson(validatedData);
        emit(ProfileLoaded(profile));
      } else {
        emit(ProfileError('Failed to load profile'));
      }
    } catch (e) {
      emit(ProfileError('Error: ${e.toString()}'));
    }
  }

  Future<void> pickAndUploadImage() async {
  try {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile == null) return;

    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(ProfileUploading(currentState.profile));
      
      final imageFile = File(pickedFile.path);
      final response = await _apiClient.uploadImage(imageFile);

      if (response.statusCode == 200) {
        final imageUrl = SecurityUtils.sanitizeInput(
          response.data['data']['photo_profile'] ?? ''
        );
        
        final updatedProfile = UserProfile(
          name: currentState.profile.name,
          username: currentState.profile.username,
          email: currentState.profile.email,
          photoProfile: imageUrl,
        );
        
        emit(ProfileLoaded(updatedProfile));
      }
    }
  } catch (e) {
    emit(ProfileError(e is SecurityException 
        ? e.toString() 
        : 'Failed to upload photo'));
  }
}

  Map<String, dynamic> _validateProfileData(Map<String, dynamic> data) {
    return {
      'name': SecurityUtils.sanitizeInput(data['name'] ?? ''),
      'username': SecurityUtils.sanitizeInput(data['username'] ?? ''),
      'email': SecurityUtils.sanitizeInput(data['email'] ?? ''),
      'photo_profile': SecurityUtils.sanitizeInput(data['photo_profile'] ?? ''),
    };
  }

  void _cleanupTempFiles() {
    try {
      final tempDir = Directory.systemTemp;
      final tempFiles = tempDir.listSync();
      for (var file in tempFiles) {
        if (file is File && file.path.contains('image_picker')) {
          file.deleteSync();
        }
      }
    } catch (e) {
      print('Error cleaning temp files: $e');
    }
  }
}
