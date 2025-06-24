import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../pages/home_page.dart';
import '../pages/bank_sampah_page.dart';
import '../pages/request_pickup_page.dart';
import '../pages/riwayat_pickup_page.dart';
import '../pages/edukasi_sampah_page.dart';
import '../pages/login_page.dart';

class TrashGoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const TrashGoAppBar({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return AppBar(
      toolbarHeight: 90,
      backgroundColor: Colors.white,
      elevation: 1,
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
          onPressed: () => _showBottomMenu(context, auth),
        ),
      ],
    );
  }

  void _showBottomMenu(BuildContext context, AuthProvider auth) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuItem(
              icon: Icons.home,
              label: 'Beranda',
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePageWrapper())),
            ),
            _menuItem(
              icon: Icons.location_on,
              label: 'Bank Sampah',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BankSampahPage())),
            ),
            _menuItem(
              icon: Icons.recycling,
              label: 'Request Pickup',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RequestPickupPage())),
            ),
            _menuItem(
              icon: Icons.history,
              label: 'Riwayat Pickup',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RiwayatPickupPage())),
            ),
            _menuItem(
              icon: Icons.menu_book,
              label: 'Edukasi Sampah',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EdukasiSampahPage())),
            ),
            const Divider(),
            _menuItem(
              icon: auth.isLoggedIn ? Icons.logout : Icons.login,
              label: auth.isLoggedIn ? 'Logout' : 'Login',
              onTap: () {
                Navigator.pop(context);
                if (auth.isLoggedIn) {
                  auth.logout();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePageWrapper()));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(label, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
