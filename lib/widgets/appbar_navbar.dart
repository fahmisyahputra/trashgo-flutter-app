import 'package:flutter/material.dart';

class TrashGoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const TrashGoAppBar({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 90, // ✅ Tambah tinggi AppBar
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
          const SizedBox(width: 8),
          Text(
            title ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
              fontSize: 22,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            // Tambahkan aksi menu jika dibutuhkan
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90); // ✅ Sesuaikan dengan toolbarHeight
}
