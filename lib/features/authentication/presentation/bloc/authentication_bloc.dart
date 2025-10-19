import 'package:bloc/bloc.dart';
import 'package:claim_online/features/authentication/domain/entities/data_register.dart';
import 'package:claim_online/features/authentication/domain/usecases/register.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:claim_online/core/error/failure.dart';
import 'package:claim_online/core/success/success.dart';
import 'package:claim_online/core/utils/auth_service.dart';
import 'package:claim_online/features/authentication/domain/entities/data_login.dart';
import 'package:claim_online/features/authentication/domain/entities/data_user_token.dart';
import 'package:claim_online/features/authentication/domain/usecases/login.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  Login login;
  Register register;

  AuthenticationBloc({
    required this.login,
    required this.register,
  }) : super(AuthenticationStateEmpty()) {
    on<AuthenticationEventEmpty>((event, emit) async {
      emit(AuthenticationStateEmpty());
    });
    on<AuthenticationEventLogin>((event, emit) async {
      try {
        emit(AuthenticationStateLoading());
        Either<Failure, DataUserToken> loginResult =
            await login.call(event.dataLogin);

        loginResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(AuthenticationStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(AuthenticationStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(AuthenticationStateError(message: l.message));
          } else {
            emit(const AuthenticationStateError(message: 'Failed Login'));
          }
        }, (r) {
          emit(AuthenticationStateLogin(dataLogin: r));
        });
      } catch (e) {
        emit(const AuthenticationStateError(message: 'Failed Login'));
      }
    });
    on<AuthenticationEventRegister>((event, emit) async {
      try {
        emit(AuthenticationStateLoading());
        Either<Failure, Success> registerResult =
            await register.call(event.dataRegister);

        registerResult.fold((l) {
          if (l is ConnectionFailure) {
            emit(AuthenticationStateError(message: l.message));
          } else if (l is ServerFailure) {
            emit(AuthenticationStateError(message: l.message));
          } else if (l is GeneralFailure) {
            emit(AuthenticationStateError(message: l.message));
          } else {
            emit(const AuthenticationStateError(message: 'Failed Register'));
          }
        }, (r) {
          if (r is GeneralSuccess) {
            emit(AuthenticationStateRegister(message: r.message));
          }
        });
      } catch (e) {
        emit(const AuthenticationStateError(message: 'Failed Register'));
      }
    });
    on<AuthenticationEventGetTokenLogin>(
      (event, emit) async {
        try {
          emit(AuthenticationStateLoading());
          DataUserToken? tokenLogin = await AuthService.getUser();
          if (tokenLogin != null) {
            emit(AuthenticationStateGetTokenLogin(tokenLogin: tokenLogin.token));
          } else {
            emit(const AuthenticationStateEmptyToken(message: 'Empty Token'));
          }
        } catch (e) {
          emit(
              const AuthenticationStateError(message: 'Failed get data Login'));
        }
      },
    );
    on<AuthenticationEventLogout>(
      (event, emit) async {
        try {
          emit(AuthenticationStateLoading());
          String? token = await AuthService.getToken();
          if (token != null) {
            await AuthService.logout();
            emit(const AuthenticationStateLogout(message: 'Success Logout'));
          } else {
            await AuthService.logout();
            emit(const AuthenticationStateLogout(message: 'Success Logout'));
          }
        } catch (e) {
          emit(AuthenticationStateError(
              message: 'Failed logout : ${e.toString()}'));
        }
      },
    );
  }
}
