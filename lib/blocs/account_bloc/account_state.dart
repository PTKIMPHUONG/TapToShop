import 'package:equatable/equatable.dart';
import '../../models/user.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final User user;

  const AccountLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class AccountError extends AccountState {
  final String error;

  const AccountError({required this.error});

  @override
  List<Object> get props => [error];
}
