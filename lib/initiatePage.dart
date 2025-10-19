import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:claim_online/core/dependency_injection/dependency_injection.dart';
import 'package:claim_online/core/utils/auth_service.dart';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:claim_online/home.dart';
import 'package:claim_online/features/authentication/presentation/pages/login_page.dart';

int? initScreen = 0;

class InitiatePage extends StatelessWidget {
  const InitiatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: serviceLocator<AuthenticationBloc>()
            ..add(const AuthenticationEventGetTokenLogin()),
          builder: (context, state) {
            logInfo('AUTH STATE INITIATE $state');
            if (state is AuthenticationStateLogin) {
              AuthService.saveUser(state.dataLogin);
              AuthService.saveToken(state.dataLogin.token);
              userRole = int.parse(state.dataLogin.roleId);
              return HomePage();
            } else if (state is AuthenticationStateGetTokenLogin) {
              return HomePage();
            } else if (state is AuthenticationStateEmptyToken) {
              return LoginPage();
            } else if (state is AuthenticationStateError) {
              return LoginPage();
            } else if (state is AuthenticationStateLogout) {
              return LoginPage();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
