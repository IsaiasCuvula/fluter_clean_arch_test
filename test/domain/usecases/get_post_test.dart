import 'package:clean_arch_test/domain/entities/post.dart';
import 'package:clean_arch_test/domain/errors/errors.dart';
import 'package:clean_arch_test/domain/repositories/post_repository.dart';
import 'package:clean_arch_test/domain/usecases/get_post.dart';
import 'package:clean_arch_test/domain/usecases/get_post_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock extends Mock implements PostRepository {}

void main() {
  final repository = PostRepositoryMock();
  final usecase = GetPostImpl(repository);
  test('return a post list ...', () async {
    //arrange
    final params = PostParams(page: 1);
    when(() => repository.fetchPosts(params)).thenAnswer(
      (_) async => const Right(<Post>[]),
    );
    //act
    final result = await usecase.call(params: params);
    //asset
    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<List<Post>>());
  });

  test('return a post exception if repository fails ...', () async {
    //arrange
    final params = PostParams(page: 1);
    when(() => repository.fetchPosts(params)).thenAnswer(
      (_) async => Left(
        PostRepositoryException('Repository fails'),
      ),
    );
    //act
    final result = await usecase.call(params: params);
    //asset
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<PostRepositoryException>());
  });

  test('return an error if params.page < 0', () async {
    //arrange
    final params = PostParams(page: 0);

    //act
    final result = await usecase(params: params);

    //assert
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidPostParams>());
  });

  test('return an error if params.offset < 0', () async {
    //arrange
    final params = PostParams(page: 1, offset: 0);

    //act
    final result = await usecase(params: params);

    //assert
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidPostParams>());
  });
}
