import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/Features/home/presentation/manager/fetch_featured_books_cubit/fetch_featured_books_cubit.dart';
import 'package:booklycleanarch/Features/home/presentation/views/widgets/featured_books_list_view_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'featured_list_view.dart';

class FeaturedBooksListViewBlocConsumer extends StatelessWidget {
  const FeaturedBooksListViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    List<BookEntity> books = [];
    return BlocConsumer<FetchFeaturedBooksCubit, FetchFeaturedBooksState>(
      listener: (context, state) {
        if (state is FetchFeaturedBooksSuccess) {
          books.addAll(state.books);
        } else if (state is FetchFeaturedBooksPaginationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is FetchFeaturedBooksSuccess ||
            state is FetchFeaturedBooksPaginationLoading ||
            state is FetchFeaturedBooksPaginationFailure) {
          return FeaturedBooksListView(books: books);
        } else if (state is FetchFeaturedBooksFailure) {
          return Text(state.errorMessage);
        } else {
          return const FeaturedBooksListViewLoadingIndicator();
        }
      },
    );
  }
}
