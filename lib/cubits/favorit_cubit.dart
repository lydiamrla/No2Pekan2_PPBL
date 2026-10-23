import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<Set<String>> {
  FavoriteCubit() : super({});

  void tandai(String bookId) {
    final himpunanBaru = Set<String>.from(state)..add(bookId);
    emit(himpunanBaru);
  }

  void batalTandai(String bookId) {
    final himpunanBaru = Set<String>.from(state)..remove(bookId);
    emit(himpunanBaru);
  }

  void toggleFavorite(String bookId) {
    if (state.contains(bookId)) {
      batalTandai(bookId);
    } else {
      tandai(bookId);
    }
  }
}