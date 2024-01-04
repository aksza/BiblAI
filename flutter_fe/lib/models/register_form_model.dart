
class RegisterForm{
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String profilePictureUrl;
  final String birthDate;
  final bool gender;
  String? bios;
  final String religion;

  RegisterForm({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.profilePictureUrl,
    required this.birthDate,
    required this.gender,
    this.bios,
    required this.religion
  });
}