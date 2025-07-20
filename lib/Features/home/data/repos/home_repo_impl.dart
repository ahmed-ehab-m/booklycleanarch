import 'package:booklycleanarch/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:booklycleanarch/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/Features/home/domain/repos/home_repo.dart';
import 'package:booklycleanarch/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async {
    try {
      // get books from cache first for best performance and better UX
      var booksList = homeLocalDataSource.fetchFeaturedBooks();
      if (booksList.isNotEmpty) return Right(booksList);

      // if the cache is empty, get books from the server
      var books = await homeRemoteDataSource.fetchFeaturedBooks();
      return Right(books);
    } on Exception catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async {
    try {
      // get books from cache first for best performance and better UX
      var booksList = homeLocalDataSource.fetchNewestBooks();
      if (booksList.isNotEmpty) return Right(booksList);

      // if the cache is empty, get books from the server
      var books = await homeRemoteDataSource.fetchNewestBooks();
      return Right(books);
    } on Exception catch (e) {
      return Left(Failure());
    }
  }
}
