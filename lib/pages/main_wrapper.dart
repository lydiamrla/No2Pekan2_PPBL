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
      color: Theme.of(context).colorScheme.primary,
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          elevation: 0,
          indicatorColor: primaryColor.withOpacity(0.2),
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: primaryColor),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.auto_stories_outlined),
              selectedIcon: Icon(Icons.auto_stories, color: primaryColor),
              label: 'Buku',
            ),
            NavigationDestination(
              icon: _buatIkonKeranjang(selected: false),
              selectedIcon: _buatIkonKeranjang(selected: true),
              label: 'Keranjang',
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: primaryColor),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}