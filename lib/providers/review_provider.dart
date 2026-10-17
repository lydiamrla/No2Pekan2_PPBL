import 'package:flutter/material.dart';

class BookReview {
  final String id;
  final String bookTitle;
  final double rating;
  final String reviewText;
  final String reviewerName;

  BookReview({
    required this.id,
    required this.bookTitle,
    required this.rating,
    required this.reviewText,
    required this.reviewerName,
  });
}

class ReviewProvider extends ChangeNotifier {
  final List<BookReview> _reviews = [
    BookReview(
      id: 'r1',
      bookTitle: 'Atomic Habits',
      rating: 5.0,
      reviewText: 'Sangat mengubah pola pikir harian saya!',
      reviewerName: 'Mahasiswa IKAPI',
    ),
  ];

  List<BookReview> get reviews => _reviews;

  void addReview(BookReview review) {
    _reviews.insert(0, review);
    notifyListeners();
  }
}