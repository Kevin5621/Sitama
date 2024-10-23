class UserProfile {
  final String? name;
  final String? username;
  final String? email;
  final String? photoProfile;

  UserProfile({
    this.name,
    this.username,
    this.email,
    this.photoProfile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      photoProfile: json['photo_profile'],
    );
  }
}