import 'package:edu_expert/data/model/book/book_model.dart';
import 'package:edu_expert/domain/use_case/get_book_use_case.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetBookUseCase _getBookUseCase;

  HomeController(this._getBookUseCase);

  Rx<List<Book>> books = Rx([]);

  void getBook() async {
    final result = await _getBookUseCase.call();

    if (result != null) {
      books(result.books);
      update();
    }
  }
}
