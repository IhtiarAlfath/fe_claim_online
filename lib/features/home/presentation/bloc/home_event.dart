part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent([List<dynamic> props = const <dynamic>[]]);
}

class HomeEventApplication extends HomeEvent {
  const HomeEventApplication();
  @override
  List<Object?> get props => [];
}

class HomeEventChangeHeadline extends HomeEvent {
  final String headline;
  const HomeEventChangeHeadline({required this.headline});
  @override
  List<Object?> get props => [headline];
}
