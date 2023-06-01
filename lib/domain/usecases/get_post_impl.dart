import 'package:clean_arch_test/domain/errors/errors.dart';
import 'package:clean_arch_test/domain/repositories/post_repository.dart';
import 'package:clean_arch_test/domain/usecases/get_post.dart';
import 'package:dartz/dartz.dart';

class GetPostImpl implements GetPost {
  final PostRepository postRepository;

  GetPostImpl(this.postRepository);
  @override
  PostResult call({required PostParams params}) async {
    if (params.page <= 0) {
      return Left(InvalidPostParams('Page less than 1'));
    }

    if (params.offset != null) {
      if (params.offset! <= 0) {
        return Left(InvalidPostParams('Page less than 1'));
      }
    }

    final posts = await postRepository.fetchPosts(params);
    return posts;
  }
}
