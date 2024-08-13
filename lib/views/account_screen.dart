import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/account_bloc/account_bloc.dart';
import '../blocs/account_bloc/account_event.dart';
import '../blocs/account_bloc/account_state.dart';
import '../repositories/user_repository.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AccountBloc(RepositoryProvider.of<UserRepository>(context))
            ..add(CheckLoginStatus()),
      child: AccountScreen(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountInitial) {
          Navigator.pushReplacementNamed(
            context, '/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AccountBloc>().add(Logout());
              },
            ),
          ],
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AccountLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User ID: ${state.user.userId}'),
                    Text('Username: ${state.user.username}'),
                    Text('Email: ${state.user.email}'),
                    Text('Gender: ${state.user.gender}'),
                    Text('Phone Number: ${state.user.phoneNumber}'),
                  ],
                ),
              );
            } else if (state is AccountError) {
              return Center(child: Text(state.error));
            }
            return Center(child: Text('Welcome!'));
          },
        ),
      ),
    );
  }
}
