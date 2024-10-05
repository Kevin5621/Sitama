class AppConstants {
  // API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String loginEndpoint = '/login';
  static const String bimbinganEndpoint = '/bimbingan';

  // SharedPreferences Keys
  static const String tokenKey = 'auth_token';
  static const String userTypeKey = 'user_type';

  // User Types
  static const String mahasiswaType = 'mahasiswa';
  static const String dosenType = 'dosen';

  // Bimbingan Status
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRevision = 'revision';

  // Messages
  static const String loginSuccessMessage = 'Login berhasil';
  static const String loginFailedMessage = 'Login gagal. Silakan coba lagi.';
  static const String networkErrorMessage = 'Terjadi kesalahan jaringan. Silakan coba lagi nanti.';

  // Dimensions
  static const double cardPadding = 16.0;
  static const double buttonHeight = 48.0;
}