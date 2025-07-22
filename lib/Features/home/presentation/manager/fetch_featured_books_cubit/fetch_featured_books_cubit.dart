import 'package:bloc/bloc.dart';
import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:meta/meta.dart';

part 'fetch_featured_books_state.dart';

class FetchFeaturedBooksCubit extends Cubit<FetchFeaturedBooksState> {
  FetchFeaturedBooksCubit(this.fetchFeaturedBooksUseCase)
    : super(FetchFeaturedBooksInitial());
  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;
  ///////////////////////////////////////////////////
  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(FetchFeaturedBooksInitial());
    } else {
      emit(FetchFeaturedBooksPaginationLoading());
    }
    var result = await fetchFeaturedBooksUseCase.call(pageNumber);
    // fold takes 2 anonumous callback functions
    result.fold(
      (failure) {
        pageNumber == 0
            ? emit(FetchFeaturedBooksFailure(failure.message))
            : emit(FetchFeaturedBooksPaginationFailure(failure.message));
      },
      (books) {
        emit(FetchFeaturedBooksSuccess(books));
      },
    );
  }
}
