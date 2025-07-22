import 'package:booklycleanarch/Features/home/domain/entities/book_entity.dart';
import 'package:booklycleanarch/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchNewestBooks();
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0});
}
////////////////////////////////////////////////////////

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0}) {
    var box = Hive.box<BookEntity>(kFeaturedBox);
    int length = box.values.length; // Get the total number of books in the box
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10; // not included in the result
    // Ensure the indices are within bounds
    // if not in range, return an empty list to fetch new page
    // from the api in remote data source
    // the number of books in last page may be less than 10
    // this cause an error if we try to access out of range
    if (startIndex >= length || endIndex > length) return [];

    return box.values.toList().sublist(startIndex, endIndex);
  }

  ////////////////////////////////////////////////////////
  @override
  List<BookEntity> fetchNewestBooks() {
    var box = Hive.box<BookEntity>(kNewestBox);
    return box.values.toList();
  }
}
