class UserController {
  static final UserController _instance = UserController._internal();
  factory UserController() => _instance;
  UserController._internal();

  final Map<String, Map<String, String>> _users = {
    'a': {'name': 'Test User', 'password': 'a'},
    'user@demo.com': {'name': 'Demo User', 'password': 'password'},
  };

  String? _currentUserEmail;

  bool login(String email, String password) {
    if (_users.containsKey(email) && _users[email]!['password'] == password) {
      _currentUserEmail = email;
      return true;
    }
    return false;
  }

  bool register(String name, String email, String password) {
    if (_users.containsKey(email)) return false;
    _users[email] = {'name': name, 'password': password};
    _currentUserEmail = email;
    return true;
  }

  bool isLoggedIn() => _currentUserEmail != null;
  String? getCurrentUserEmail() => _currentUserEmail;
  String? getCurrentUserName() => _currentUserEmail == null ? null : _users[_currentUserEmail]?['name'];
  void logout() => _currentUserEmail = null;
}
