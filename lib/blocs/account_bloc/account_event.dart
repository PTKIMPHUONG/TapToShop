import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class CheckLoginStatus extends AccountEvent {}

class LoadUserData extends AccountEvent {
  final String userId;

  LoadUserData({required this.userId});

  @override
  List<Object> get props => [userId];
}

class Logout extends AccountEvent {}
