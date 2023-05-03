import 'package:edu_expert/data/datasource/book_remote.datasource.dart';
import 'package:edu_expert/data/model/book_response/book_response_model.dart';
import 'package:edu_expert/domain/repository/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDatasource _remoteDatasource;

  const BookRepositoryImpl(this._remoteDatasource);
  @override
  Future<BookResponse?> getBook() async => await _remoteDatasource.getbook();

  @override
  Future<void> addBook() {
    throw UnimplementedError();
  }
}
