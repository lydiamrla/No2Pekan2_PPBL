class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final String category;
  final String description;
  final String image;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
  });
}

final List<Book> dummyBooks = [
  Book(
    id: 'b1',
    title: 'Atomic Habits',
    author: 'James Clear',
    price: 108000,
    category: 'Pengembangan Diri',
    description: 'Buku yang memberikan panduan praktis untuk membangun kebiasaan baik dan menghilangkan kebiasaan buruk.',
    image: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=500&q=80',
  ),
  Book(
    id: 'b2',
    title: 'Filosofi Teras',
    author: 'Henry Manampiring',
    price: 98000,
    category: 'Filsafat',
    description: 'Penerapan filsafat Stoisisme dalam kehidupan modern untuk mengelola emosi negatif.',
    image: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500&q=80',
  ),
  Book(
    id: 'b3',
    title: 'Laut Bercerita',
    author: 'Leila S. Chudori',
    price: 115000,
    category: 'Fiksi',
    description: 'Novel sejarah yang mengisahkan perjuangan para aktivis mahasiswa pada era Orde Baru.',
    image: 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500&q=80',
  ),
  Book(
    id: 'b4',
    title: 'The Psychology of Money',
    author: 'Morgan Housel',
    price: 95000,
    category: 'Keuangan',
    description: 'Pelajaran berharga mengenai perilaku, pola pikir, dan psikologi manusia dalam mengelola uang.',
    image: 'https://images.unsplash.com/photo-1592496001020-d31bd830651f?w=500&q=80',
  ),
  Book(
    id: 'b5',
    title: 'Bumi',
    author: 'Tere Liye',
    price: 89000,
    category: 'Fiksi',
    description: 'Petualangan tiga remaja yang menemukan dunia paralel dengan kekuatan super.',
    image: 'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=500&q=80',
  ),
];