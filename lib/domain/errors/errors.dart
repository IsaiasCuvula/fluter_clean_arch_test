abstract class PostException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const PostException(this.message, [this.stackTrace]);
}
