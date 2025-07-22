part of 'fetch_featured_books_cubit.dart';

@immutable
sealed class FetchFeaturedBooksState {}

final class FetchFeaturedBooksInitial extends FetchFeaturedBooksState {}

final class FetchFeaturedBooksLoading extends FetchFeaturedBooksState {}

final class FetchFeaturedBooksPaginationLoading
    extends FetchFeaturedBooksState {}

final class FetchFeaturedBooksPaginationFailure
    extends FetchFeaturedBooksState {
  final String errorMessage;

  FetchFeaturedBooksPaginationFailure(this.errorMessage);
}

final class FetchFeaturedBooksSuccess extends FetchFeaturedBooksState {
  final List<BookEntity> books;

  FetchFeaturedBooksSuccess(this.books);
}

final class FetchFeaturedBooksFailure extends FetchFeaturedBooksState {
  final String errorMessage;

  FetchFeaturedBooksFailure(this.errorMessage);
}
