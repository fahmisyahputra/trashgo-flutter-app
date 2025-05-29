import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green[800],
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: onTap,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Cari Bank Sampah'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Request Pickup'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat Pickup'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Edukasi Sampah'),
      ],
    );
  }
}
