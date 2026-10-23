import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cart_cubit.dart';
import '../models/book.dart';
import 'home_page.dart';
import 'books_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class MainWrapper extends StatefulWidget {
  final int initialIndex;
  const MainWrapper({super.key, this.initialIndex = 0});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    HomePage(),
    BooksPage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  Widget _buatIkonKeranjang({required bool selected}) {
    final iconBase = Icon(
      selected ? Icons.shopping_bag : Icons.shopping_bag_outlined,
      color: const Color(0xFF6C5CE7),
    );
    return BlocSelector<CartCubit, List<Book>, int>(
      selector: (state) => state.length,
      builder: (context, total) {
        if (total == 0) return iconBase;
        return Badge(
          label: Text('$total'),
          child: iconBase,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          elevation: 0,
          indicatorColor: const Color(0xFF6C5CE7).withOpacity(0.2),
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Color(0xFF6C5CE7)),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.auto_stories_outlined),
              selectedIcon: Icon(Icons.auto_stories, color: Color(0xFF6C5CE7)),
              label: 'Buku',
            ),
            NavigationDestination(
              icon: _buatIkonKeranjang(selected: false),
              selectedIcon: _buatIkonKeranjang(selected: true),
              label: 'Keranjang',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: Color(0xFF6C5CE7)),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}