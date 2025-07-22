import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/Features/home/domain/repos/home_repo.dart';
import 'package:booklycleanarch/core/errors/failure.dart';
import 'package:booklycleanarch/core/use_cases/use_case.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;
  FetchFeaturedBooksUseCase(this.homeRepo);
  // call is the function that will be used to call the use case or execute

  @override
  // using ? to make it nullable , because any object is   non nullable by default
  Future<Either<Failure, List<BookEntity>>> call([int param = 0]) async {
    return await homeRepo.fetchFeaturedBooks(pageNumber: param);
  }
}
