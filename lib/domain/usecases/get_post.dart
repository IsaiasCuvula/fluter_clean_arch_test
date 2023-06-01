import 'package:clean_arch_test/domain/entities/post.dart';
import 'package:clean_arch_test/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

typedef PostResult = Future<Either<PostException, List<Post>>>;

abstract class GetPost {
  PostResult call({required PostParams params});
}

class PostParams {
  final int page;
  final int? offset;

  PostParams({required this.page, this.offset});
}
