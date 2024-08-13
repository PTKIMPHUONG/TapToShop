import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_event.dart';
import '../blocs/login_bloc/login_state.dart';
import '../services/auth_service.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        RepositoryProvider.of<AuthenticationService>(context),
      ),
      child: LoginScreen(),
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, '/main');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(
                          LoginWithEmail(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginWithGoogle());
                  },
                  child: Text('Login with Google'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
