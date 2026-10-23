import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/book.dart';
import '../models/review.dart';
import '../navigation/app_routes.dart';
import '../cubits/review_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 100.0,
            floating: true,
            title: Text('IKAPI BookStore', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Populer Minggu Ini 🔥', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dummyBooks.length,
                      itemBuilder: (context, index) {
                        final book = dummyBooks[index];
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(context, AppRoutes.bookDetail, arguments: book),
                          child: Container(
                            width: 130,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(book.image, height: 150, width: 130, fit: BoxFit.cover),
                                ),
                                const SizedBox(height: 6),
                                Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text('Ulasan Pembaca Terbaru 💬', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  
                  // Menggunakan BlocBuilder untuk merender ulasan dari ReviewCubit
                  BlocBuilder<ReviewCubit, List<Review>>(
                    builder: (context, reviews) {
                      if (reviews.isEmpty) {
                        return const Text('Belum ada ulasan.');
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          final rev = reviews[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text('${rev.bookTitle} (${rev.rating}⭐)'),
                              subtitle: Text('"${rev.reviewText}" - ${rev.reviewerName}'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addReview);
        },
        backgroundColor: const Color(0xFF6C5CE7),
        icon: const Icon(Icons.rate_review, color: Colors.white),
        label: const Text('Tulis Ulasan', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}