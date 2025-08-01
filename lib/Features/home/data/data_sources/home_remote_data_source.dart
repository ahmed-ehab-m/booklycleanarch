import 'package:booklycleanarch/Features/home/data/models/book/book.dart';
import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/constants.dart';
import 'package:booklycleanarch/core/utils/api_service.dart';
import 'package:booklycleanarch/core/utils/functions/saveBooks.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchNewestBooks();
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService _apiService;
  HomeRemoteDataSourceImpl(this._apiService);
  ////////////////////////////////////////////
  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    var data = await _apiService.get(
      endPoint:
          'volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber * 10}', // * 10 because each page has 10 books
    );
    List<BookEntity> books = getBooksList(data);
    // cache the books
    saveBooks(books, kFeaturedBox);
    return books;
  }

  ///////////////////////////////////////////////
  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await _apiService.get(
      endPoint: 'volumes?Filtering=free-ebooks&Sorting=newest&  q=programming',
    );
    List<BookEntity> books = getBooksList(data);
    // cache the books
    saveBooks(books, kNewestBox);
    return books;
  }

  //////////////////////////////////////////////////
  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
