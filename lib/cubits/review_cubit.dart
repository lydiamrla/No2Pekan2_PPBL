import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/review.dart';

class ReviewCubit extends Cubit<List<Review>> {
  ReviewCubit() : super([]);

  void addReview(Review review) {
    emit([...state, review]);
  }
}