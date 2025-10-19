import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  const Success([List<dynamic> props = const <dynamic>[]]);
}

class GeneralSuccess extends Success {
  final String message;
  const GeneralSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class ConnectionSuccess extends Success {
  final String message;

  const ConnectionSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerSuccess extends Success {
  final String message;

  const ServerSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}
