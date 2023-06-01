abstract class PostException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const PostException(this.message, [this.stackTrace]);
}

class InvalidPostParams extends PostException {
  InvalidPostParams(super.message);
}

class PostRepositoryException extends PostException {
  PostRepositoryException(String message, [StackTrace? e]) : super(message, e);
}
