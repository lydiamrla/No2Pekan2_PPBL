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

// Data Dummy 10 Buku IKAPI
final List<Book> dummyBooks = [
  Book(
    id: 'b1',
    title: 'Atomic Habits',
    author: 'James Clear',
    price: 108000,
    category: 'Pengembangan Diri',
    description: 'Buku yang memberikan panduan praktis untuk membangun kebiasaan baik dan menghilangkan kebiasaan buruk dengan perubahan-perubahan kecil yang konsisten.',
    image: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=500&q=80',
  ),
  Book(
    id: 'b2',
    title: 'Filosofi Teras',
    author: 'Henry Manampiring',
    price: 98000,
    category: 'Filsafat / Self-Help',
    description: 'Penerapan filsafat Stoisisme dalam kehidupan modern untuk membantu mengelola emosi negatif dan menemukan kedamaian pikiran.',
    image: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500&q=80',
  ),
  Book(
    id: 'b3',
    title: 'Laut Bercerita',
    author: 'Leila S. Chudori',
    price: 115000,
    category: 'Fiksi / Novel',
    description: 'Novel sejarah yang mengisahkan perjuangan para aktivis mahasiswa pada era Orde Baru dan kisah kehilangan keluarga yang ditinggalkan.',
    image: 'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500&q=80',
  ),
  Book(
    id: 'b4',
    title: 'The Psychology of Money',
    author: 'Morgan Housel',
    price: 95000,
    category: 'Keuangan',
    description: 'Pelajaran berharga mengenai perilaku, pola pikir, dan psikologi manusia dalam mengelola uang, kekayaan, dan keputusan finansial.',
    image: 'https://images.unsplash.com/photo-1592496001020-d31bd830651f?w=500&q=80',
  ),
  Book(
    id: 'b5',
    title: 'Bumi',
    author: 'Tere Liye',
    price: 89000,
    category: 'Fiksi / Fantasi',
    description: 'Petualangan tiga remaja yang menemukan dunia paralel di mana mereka memiliki kekuatan super dan menghadapi tantangan besar.',
    image: 'https://images.unsplash.com/photo-1532012197267-da84d127e765?w=500&q=80',
  ),
  Book(
    id: 'b6',
    title: 'Negeri 5 Menara',
    author: 'Ahmad Fuadi',
    price: 85000,
    category: 'Fiksi / Edukasi',
    description: 'Kisah 6 santri dari berbagai daerah yang disatukan di pesantren dan memegang teguh mantra "Man Jadda Wajada" untuk meraih mimpi mereka.',
    image: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=500&q=80',
  ),
  Book(
    id: 'b7',
    title: 'Laskar Pelangi',
    author: 'Andrea Hirata',
    price: 90000,
    category: 'Fiksi / Inspiratif',
    description: 'Kisah perjuangan 10 anak di Belitung beserta guru-guru mereka dalam mempertahankan semangat belajar di tengah keterbatasan fasilitas.',
    image: 'https://images.unsplash.com/photo-1495640388908-05fa85288e61?w=500&q=80',
  ),
  Book(
    id: 'b8',
    title: 'Harry Potter and the Sorcerer\'s Stone',
    author: 'J.K. Rowling',
    price: 150000,
    category: 'Fiksi / Fantasi',
    description: 'Petualangan seorang anak yatim piatu yang menemukan fakta bahwa ia adalah penyihir hebat dan memulai studi di Sekolah Hogwarts.',
    image: 'https://images.unsplash.com/photo-1626618012641-bfbca5a31239?w=500&q=80',
  ),
  Book(
    id: 'b9',
    title: 'Rich Dad Poor Dad',
    author: 'Robert T. Kiyosaki',
    price: 105000,
    category: 'Keuangan',
    description: 'Membedah perbedaan cara pandang orang kaya dan orang biasa terhadap uang, investasi, serta pentingnya literasi keuangan sejak dini.',
    image: 'https://images.unsplash.com/photo-1553729459-efe14ef6055d?w=500&q=80',
  ),
  Book(
    id: 'b10',
    title: 'Perahu Kertas',
    author: 'Dee Lestari',
    price: 88000,
    category: 'Fiksi / Romantis',
    description: 'Kisah pasang surut ikatan persahabatan, seni, serta percintaan antara Kugy dan Keenan dalam mengejar cita-cita hidup mereka.',
    image: 'https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=500&q=80',
  ),
];