import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class AuthenticationService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserRepository _userRepository = UserRepository();

  Future<User?> loginWithEmail(String email, String password) async {
    User? user = await _userRepository.getUserByEmail(email);
    if (user != null && user.password == password) {
      // Lưu trạng thái đăng nhập
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.userId);
      await prefs.setBool('isLoggedIn', true);
      return user;
    }
    return null;
  }

  Future<User?> loginWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      User? user = await _userRepository.getUserByEmail(googleUser.email);
      if (user == null) {
        final newUser = User(
          userId: googleUser.id,
          username: googleUser.displayName ?? 'Unknown',
          gender: '',
          email: googleUser.email,
          password: 'auto-generated-password',
          phoneNumber: '',
        );
        await _userRepository.saveUser(newUser);
        user = newUser;
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.userId);
      await prefs.setBool('isLoggedIn', true);
      return user;
    } else {
      throw Exception('Google sign-in failed');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('isLoggedIn');
    await _googleSignIn.signOut();
  }
}
