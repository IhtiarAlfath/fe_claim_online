part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState([List<dynamic> props = const <dynamic>[]]);
}

class AuthenticationStateEmpty extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateError extends AuthenticationState {
  final String message;

  const AuthenticationStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthenticationStateEmptyToken extends AuthenticationState {
  final String message;

  const AuthenticationStateEmptyToken({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthenticationStateLogin extends AuthenticationState {
  final DataUserToken dataLogin;

  const AuthenticationStateLogin({required this.dataLogin});
  @override
  List<Object?> get props => [dataLogin];
}

class AuthenticationStateRegister extends AuthenticationState {
  final String message;

  const AuthenticationStateRegister({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthenticationStateGetTokenLogin extends AuthenticationState {
  final String? tokenLogin;

  const AuthenticationStateGetTokenLogin({required this.tokenLogin});
  @override
  List<Object?> get props => [tokenLogin];
}

class AuthenticationStateLogout extends AuthenticationState {
  final String message;

  const AuthenticationStateLogout({required this.message});
  @override
  List<Object?> get props => [message];
}


class AuthenticationStateErrorConnection extends AuthenticationState {
  final String message;

  const AuthenticationStateErrorConnection({required this.message});
  @override
  List<Object?> get props => [message];
}

class AuthenticationStateErrorNoData extends AuthenticationState {
  final String message;

  const AuthenticationStateErrorNoData({required this.message});
  @override
  List<Object?> get props => [message];
}
