import 'package:edu_expert/data/model/book_response/book_response_model.dart';

abstract class BookRepository {
  Future<BookResponse?> getBook();

  Future<void> addBook();
}
