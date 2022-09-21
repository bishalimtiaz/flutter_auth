class UserInfo {
  String? _userName;
  String? _phoneNumber;
  String? _email;
  String? _gender;
  String? _age;
  DateTime? _birthDate;

  UserInfo({
    String? userName,
    String? phoneNumber,
    String? email,
    String? gender,
    String? age,
    DateTime? birthDate,
  })  : _userName = userName,
        _phoneNumber = phoneNumber,
        _email = email,
        _gender = gender,
        _age = age,
        _birthDate = birthDate;

  String? get userName => _userName;

  String? get phoneNumber => _phoneNumber;

  String? get email => _email;

  String? get gender => _gender;

  String? get age => _age;

  DateTime? get birthDate => _birthDate;

  void updateUserName({required String userName}) => _userName = userName;

  void updatePhoneNumber({required String phoneNumber}) =>
      _phoneNumber = phoneNumber;

  void updateEmail({required String email}) => _email = email;

  void updateGender({required String gender}) => _gender = gender;

  void updateAge({required String age}) => _age = age;

  void updateBirthdate({required DateTime birthdate}) => _birthDate = birthDate;

  void updateUserInfo({
    required String userName,
    required String phoneNumber,
    required String email,
    required String gender,
    required String age,
    required DateTime birthdate
  }) {
    _userName = userName;
    _phoneNumber = phoneNumber;
    _email = email;
    _gender = gender;
    _age = age;
    _birthDate = birthDate;
  }
}
