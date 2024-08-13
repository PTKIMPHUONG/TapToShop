import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';
import '../../repositories/user_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _authenticationService;
  final UserRepository _userRepository = UserRepository(); 
  LoginBloc(this._authenticationService) : super(LoginInitial()) {
    on<LoginWithEmail>(_onLoginWithEmail);
    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }

  // Handle login with email event
  Future<void> _onLoginWithEmail(LoginWithEmail event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await _authenticationService.loginWithEmail(event.email, event.password);
      if (user != null) {
        emit(LoginSuccess(user: user));
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', user.userId);
      } else {
        emit(const LoginFailure(error: 'Invalid email or password'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  // Handle login with Google event
  Future<void> _onLoginWithGoogle(LoginWithGoogle event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final user = await _authenticationService.loginWithGoogle();
      if (user != null) {
        emit(LoginSuccess(user: user));
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', user.userId);
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  // Handle check login status event
  Future<void> _onCheckLoginStatus(CheckLoginStatus event, Emitter<LoginState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      final userId = prefs.getString('userId');
      final user = await _userRepository.getUserById(userId ?? '');
      if (user != null) {
        emit(LoginSuccess(user: user));
      } else {
        emit(LoginFailure(error: 'User not found'));
      }
    } else {
      emit(LoginInitial());
    }
  }

  // Handle logout request event
  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<LoginState> emit) async {
    await _authenticationService.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userId');
    emit(LoginInitial());
  }
}
