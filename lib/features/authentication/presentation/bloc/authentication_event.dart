part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([List<dynamic> props = const <dynamic>[]]);
}

class AuthenticationEventEmpty extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class AuthenticationEventLoading extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class AuthenticationEventError extends AuthenticationEvent {
  final String message;

  const AuthenticationEventError({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final DataLogin dataLogin;

  const AuthenticationEventLogin({required this.dataLogin});
  @override
  List<Object?> get props => [dataLogin];
}

class AuthenticationEventRegister extends AuthenticationEvent {
  final DataRegister dataRegister;

  const AuthenticationEventRegister({required this.dataRegister});
  @override
  List<Object?> get props => [dataRegister];
}

class AuthenticationEventLogout extends AuthenticationEvent {
  const AuthenticationEventLogout();
  @override
  List<Object?> get props => [];
}

class AuthenticationEventGetTokenLogin extends AuthenticationEvent {
  const AuthenticationEventGetTokenLogin();
  @override
  List<Object?> get props => [];
}
