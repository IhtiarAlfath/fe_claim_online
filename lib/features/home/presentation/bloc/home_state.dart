part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState([List<dynamic> props = const <dynamic>[]]);
}

class HomeStateEmpty extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeStateLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeStateError extends HomeState {
  final String message;

  const HomeStateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class HomeStateApplication extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeStateChangeHeadline extends HomeState {
  final String headline;
  const HomeStateChangeHeadline({required this.headline});
  @override
  List<Object?> get props => [headline];
}

