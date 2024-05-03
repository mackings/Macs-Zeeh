// ignore_for_file: annotate_overrides, overridden_fields

abstract class Failure {
  final String title;
  final String message;

  const Failure(this.title, this.message);

  List<Object> get props => [title, message];
}

class NoFailure extends Failure {
  NoFailure([super.title = '', super.message = '']);
}

class ServerFailure extends Failure {
  final String title;
  final String message;

  const ServerFailure(this.title, this.message) : super(title, message);
}

class CacheFailure extends Failure {
  final String title;
  final String message;

  const CacheFailure({required this.title, required this.message})
      : super(title, message);
}

class CommonFailure extends Failure {
  const CommonFailure(final String title, final String message)
      : super(title, message);
}

class InternetFailure extends Failure {
  const InternetFailure(final String title, final String message)
      : super(title, message);
}

class AuthenticationFailure extends Failure {
  final String title;
  final String message;

  const AuthenticationFailure(this.title, this.message) : super(title, message);
}
