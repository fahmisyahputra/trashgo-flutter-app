import 'package:flutter/material.dart';
import 'bank_sampah_page.dart';
import 'request_pickup_page.dart';
import 'riwayat_pickup_page.dart';
import 'edukasi_sampah_page.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/appbar_navbar.dart';

class HomePageWrapper extends StatefulWidget {
  const HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    _homeContent(), 
    BankSampahPage(),
    RequestPickupPage(),
    RiwayatPickupPage(),
    EdukasiSampahPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? TrashGoAppBar() : null, 
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  static Widget _homeContent() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _HomeContentWidget(),
      ),
    );
  }
}

class _HomeContentWidget extends StatefulWidget {
  @override
  State<_HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<_HomeContentWidget> {
  String searchQuery = '';

  void _navigateToBankSampah() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BankSampahPage(searchQuery: searchQuery),
      ),
    );
  }

  void _navigateToRequestPickup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RequestPickupPage()),
    );
  }

  void _navigateToEdukasi() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EdukasiSampahPage()),
    );
  }

  void _navigateToRiwayat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RiwayatPickupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyleActive = ElevatedButton.styleFrom(
      backgroundColor: Colors.green[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      minimumSize: const Size(double.infinity, 140),
    );

    final buttonStyleInactive = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      foregroundColor: Colors.black,
      elevation: 0,
      minimumSize: const Size(double.infinity, 140),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // Banner Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/banner_recycle.png',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),

        const Text(
          'Welcome to TrashGo!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),

        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: buttonStyleActive,
                    onPressed: _navigateToBankSampah,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.place, size: 40, color: Colors.white),
                        SizedBox(height: 12),
                        Text(
                          'Bank Sampah',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: buttonStyleInactive,
                    onPressed: _navigateToRequestPickup,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_box_outlined, size: 40, color: Colors.black),
                        SizedBox(height: 12),
                        Text(
                          'Request Pickup',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: buttonStyleActive,
                    onPressed: _navigateToEdukasi,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.article_outlined, size: 40, color: Colors.white),
                        SizedBox(height: 12),
                        Text(
                          'Edukasi Sampah',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: buttonStyleInactive,
                    onPressed: _navigateToRiwayat,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.history_outlined, size: 40, color: Colors.black),
                        SizedBox(height: 12),
                        Text(
                          'Riwayat Pickup',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.grey.shade100,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Cari Bank Sampah...',
              border: InputBorder.none,
              icon: Icon(Icons.search),
            ),
            onChanged: (val) {
              setState(() {
                searchQuery = val;
              });
            },
            onSubmitted: (val) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BankSampahPage(searchQuery: val),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
