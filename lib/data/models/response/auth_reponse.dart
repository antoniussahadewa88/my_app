class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? image;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.image,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
    );
  }
}