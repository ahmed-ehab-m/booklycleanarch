import 'package:booklycleanarch/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:booklycleanarch/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/Features/home/domain/repos/home_repo.dart';
import 'package:booklycleanarch/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks({
    int pageNumber = 0,
  }) async {
    try {
      // get books from cache first for best performance and better UX
      List<BookEntity> books;

      books = homeLocalDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      if (books.isNotEmpty) return Right(books);

      // if the cache is empty, get books from the server
      books = await homeRemoteDataSource.fetchFeaturedBooks(
        pageNumber: pageNumber,
      );
      return Right(books);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  ///////////////////////////////////////////////////////////

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks() async {
    try {
      List<BookEntity> books;
      // get books from cache first for best performance and better UX
      books = homeLocalDataSource.fetchNewestBooks();
      if (books.isNotEmpty) return Right(books);

      // if the cache is empty, get books from the server
      books = await homeRemoteDataSource.fetchNewestBooks();
      return Right(books);
    } catch (e) {
      //cause dio handles the exceptions about the server
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
