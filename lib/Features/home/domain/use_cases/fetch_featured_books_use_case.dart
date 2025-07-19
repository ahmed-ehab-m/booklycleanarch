import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/Features/home/domain/repos/home_repo.dart';
import 'package:booklycleanarch/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase {
  final HomeRepo homeRepo;
  FetchFeaturedBooksUseCase(this.homeRepo);
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() {
    return homeRepo.fetchFeaturedBooks();
  }
}
