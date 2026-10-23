import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book.dart';

class CartCubit extends Cubit<List<Book>> {
  CartCubit() : super([]);

  int get totalItem => state.length;

  void tambahKeKeranjang(Book book) {
    if (!state.any((item) => item.id == book.id)) {
      final daftarBaru = List<Book>.from(state)..add(book);
      emit(daftarBaru);
    }
  }

  void hapusDariKeranjang(Book book) {
    final daftarBaru = state.where((item) => item.id != book.id).toList();
    emit(daftarBaru);
  }

  void bersihkanKeranjang() {
    emit([]);
  }

  bool isBookInCart(Book book) {
    return state.any((item) => item.id == book.id);
  }

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.price);
  }
}