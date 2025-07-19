import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchNewestBooks();
  List<BookEntity> fetchFeaturedBooks();
}
////////////////////////////////////////////////////////

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks() {}
  ////////////////////////////////////////////////////////
  @override
  List<BookEntity> fetchNewestBooks() {}
}
