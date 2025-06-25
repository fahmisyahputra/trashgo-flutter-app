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
          onPressed: () => showRightSideMenu(context, auth),
        ),
      ],
    );
  }

  void showRightSideMenu(BuildContext context, AuthProvider auth) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Menu",
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  menuItem(
                    icon: Icons.home,
                    label: 'Beranda',
                    onTap: () => navigate(context, const HomePageWrapper()),
                  ),
                  menuItem(
                    icon: Icons.location_on,
                    label: 'Bank Sampah',
                    onTap: () => navigate(context, BankSampahPage()),
                  ),
                  menuItem(
                    icon: Icons.recycling,
                    label: 'Request Pickup',
                    onTap: () => navigate(context, RequestPickupPage()),
                  ),
                  menuItem(
                    icon: Icons.history,
                    label: 'Riwayat Pickup',
                    onTap: () => navigate(context, RiwayatPickupPage()),
                  ),
                  menuItem(
                    icon: Icons.menu_book,
                    label: 'Edukasi Sampah',
                    onTap: () => navigate(context, EdukasiSampahPage()),
                  ),
                  const Divider(),
                  menuItem(
                    icon: auth.isLoggedIn ? Icons.logout : Icons.login,
                    label: auth.isLoggedIn ? 'Logout' : 'Login',
                    onTap: () {
                      Navigator.pop(context);
                      if (auth.isLoggedIn) {
                        auth.logout();
                        navigate(context, const HomePageWrapper());
                      } else {
                        navigate(context, const LoginPage());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      transitionBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  void navigate(BuildContext context, Widget page) {
    Navigator.pop(context); // Tutup menu dulu
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget menuItem({required IconData icon, required String label, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(label, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
