import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _email;
  String? _role; // 'admin' atau 'user'
  bool get isLoggedIn => _email != null;
  String? get email => _email;
  String? get role => _role;

  // Hardcoded admin
  final String _adminEmail = 'admin@email.com';
  final String _adminPassword = 'admin123';

  // Simpan user terdaftar (email, password)
  final Map<String, String> _registeredUsers = {};

  // Register user baru
  String? register(String email, String password) {
    if (_registeredUsers.containsKey(email)) {
      return 'Email sudah terdaftar';
    }
    _registeredUsers[email] = password;
    notifyListeners();
    return null; // null artinya sukses
  }

  // Login
  String? login(String email, String password) {
    // Admin hardcoded
    if (email == _adminEmail && password == _adminPassword) {
      _email = email;
      _role = 'admin';
      notifyListeners();
      return 'admin'; 
    }

    // Cek apakah user terdaftar
    if (_registeredUsers.containsKey(email) &&
        _registeredUsers[email] == password) {
      _email = email;
      _role = 'user';
      notifyListeners();
      return 'user'; 
    }

    return null; // jika gagal login
  }

  void logout() {
    _email = null;
    _role = null;
    notifyListeners();
  }
}
