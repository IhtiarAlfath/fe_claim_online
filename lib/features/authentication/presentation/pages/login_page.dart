import 'package:claim_online/core/utils/auth_service.dart';
import 'package:claim_online/core/utils/function.dart';
import 'package:claim_online/features/authentication/domain/entities/data_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:claim_online/features/authentication/presentation/bloc/authentication_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black12,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Image.asset('assets/images/asabri_icon.png'),
                  ),
                ),
                const Text(
                  'Sing In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 41, 58, 86),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'email',
                    floatingLabelStyle:
                        const TextStyle(color: Colors.blueAccent),
                    prefixIcon: const Icon(Icons.mail),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    floatingLabelStyle:
                        const TextStyle(color: Colors.blueAccent),
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Minimum 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have account? "),
                    GestureDetector(
                      onTap: () {
                        context.goNamed('registerpage');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, authstate) {
                    logInfo(authstate.toString());
                    if (authstate is AuthenticationStateLogin) {
                      AuthService.saveUser(authstate.dataLogin);
                      AuthService.saveToken(authstate.dataLogin.token);
                      userRole = int.parse(authstate.dataLogin.roleId);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.goNamed('homepage');
                      });
                    } else if (authstate is AuthenticationStateError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showPopupNotification(context, authstate.message);
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationEventEmpty());
                      });
                    }

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: const Color(0xFF3B82F6),
                        ),
                        onPressed: () async {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            loginFunction(context);
                          } else {
                            showPopupNotification(
                                context, "Email and Password Required!");
                          }
                        },
                        child: Text(
                          authstate is AuthenticationStateLoading
                              ? 'Loading...'
                              : 'Login',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginFunction(BuildContext context) {
    final email = emailController.text;
    final password = passwordController.text;
    DataLogin dataLoginParameter = DataLogin(email: email, password: password);
    context
        .read<AuthenticationBloc>()
        .add(AuthenticationEventLogin(dataLogin: dataLoginParameter));
  }
}
