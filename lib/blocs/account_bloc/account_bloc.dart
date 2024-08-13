import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repositories/user_repository.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository _userRepository;

  AccountBloc(this._userRepository) : super(AccountInitial()) {
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<LoadUserData>(_onLoadUserData);
    on<Logout>(_onLogout);
  }

  //Handle check login status event
  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      final userId = prefs.getString('userId') ?? '';
      add(LoadUserData(userId: userId));
    } else {
      emit(AccountInitial as AccountState);
    }
  }

  //Handle load user data event
  Future<void> _onLoadUserData(
      LoadUserData event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      final user = await _userRepository.getUserById(event.userId);
      if (user != null) {
        emit(AccountLoaded(user: user));
      } else {
        emit(AccountError(error: "User not found"));
      }
    } catch (e) {
      emit(AccountError(error: e.toString()));
    }
  }

  //Handle logout event
  Future<void> _onLogout(Logout event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userId');
    emit(AccountInitial());
  }
}
