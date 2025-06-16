import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';

abstract class HomeRepo {
  Future<List<BookEntity>> fetchNewestBooks();
  Future<List<BookEntity>> fetchFeaturedBooks();
}
