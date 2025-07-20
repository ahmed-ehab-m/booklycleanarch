import 'package:bloc/bloc.dart';
import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'package:meta/meta.dart';

part 'fetch_newest_books_state.dart';

class FetchNewestBooksCubit extends Cubit<FetchNewestBooksState> {
  FetchNewestBooksCubit(this.fetchNewestBooksUseCase)
    : super(FetchNewestBooksInitial());
  final FetchNewestBooksUseCase fetchNewestBooksUseCase;
  ///////////////////////////////////////////////////
  Future<void> fetchNewestBooks() async {
    emit(FetchNewestBooksLoading());
    var result = await fetchNewestBooksUseCase.call();
    // fold takes 2 anonumous callback functions
    result.fold(
      (failure) {
        emit(FetchNewestBooksFailure(failure.message));
      },
      (books) {
        emit(FetchNewestBooksSuccess(books));
      },
    );
  }
}
