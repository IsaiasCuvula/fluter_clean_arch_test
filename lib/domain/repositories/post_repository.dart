import 'package:clean_arch_test/domain/usecases/get_post.dart';

abstract class PostRepository {
  PostResult fetchPosts(PostParams params);
}
