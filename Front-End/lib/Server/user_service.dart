class UserService {
  static final UserService _instance = UserService._internal();

  String? _uid;
  String? _email;
  String? _name;

  factory UserService() {
    return _instance;
  }

  UserService._internal();

  void setUserData({
    required String uid,
    required String email,
    required String name,
  }) {
    _uid = uid;
    _email = email;
    _name = name;
  }

  String? get uid => _uid;
  String? get email => _email;
  String? get name => _name;
}
