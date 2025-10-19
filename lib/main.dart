import 'package:claim_online/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim/claim_bloc.dart';
import 'package:claim_online/features/claim/claim/presentation/bloc/claim_general/claim_general_bloc.dart';
import 'package:claim_online/features/claim/claim_category/presentation/bloc/claim_category_bloc.dart';
import 'package:claim_online/features/claim/claim_status/presentation/bloc/claim_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'core/router/router.dart';
import 'core/utils/constant.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

void main() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //     initScreen = preferences.getInt('initScreen');
  // await preferences.setInt('initScreen', 1);
  await initDependecyInjection();
  runApp(const ClaimOnline());
}

class ClaimOnline extends StatelessWidget {
  const ClaimOnline({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => serviceLocator<AuthenticationBloc>(),
        ),
        BlocProvider<ClaimGeneralBloc>(
          create: (context) => serviceLocator<ClaimGeneralBloc>(),
        ),
        BlocProvider<ClaimBloc>(
          create: (context) => serviceLocator<ClaimBloc>(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => serviceLocator<UserBloc>(),
        ),
        BlocProvider<ClaimCategoryBloc>(
          create: (context) => serviceLocator<ClaimCategoryBloc>(),
        ),
        BlocProvider<ClaimStatusBloc>(
          create: (context) => serviceLocator<ClaimStatusBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Claim Online',
        routerConfig: router,
        theme: ThemeData(
          primaryColor: primaryColor,
          canvasColor: canvasColor,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
