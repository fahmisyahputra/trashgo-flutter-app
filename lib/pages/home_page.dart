import 'package:flutter/material.dart';
import 'bank_sampah_page.dart';
import 'request_pickup_page.dart';
import 'riwayat_pickup_page.dart';
import 'edukasi_sampah_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';

  void _navigateTo(int index) {
    Widget targetPage;
    switch (index) {
      case 0:
        targetPage = BankSampahPage(searchQuery: searchQuery);
        break;
      case 1:
        targetPage = RequestPickupPage();
        break;
      case 2:
        targetPage = EdukasiSampahPage();
        break;
      case 3:
        targetPage = RiwayatPickupPage();
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyleActive = ElevatedButton.styleFrom(
      backgroundColor: Colors.green[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 12),
      minimumSize: Size(double.infinity, 140),
    );
    final buttonStyleInactive = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      foregroundColor: Colors.black,
      elevation: 0,
      minimumSize: Size(double.infinity, 140),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('TrashGo'),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/banner_recycle.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              Text(
                'Welcome to TrashGo!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 16),

              // Tombol 2x2 memenuhi lebar
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: buttonStyleActive,
                          onPressed: () => _navigateTo(0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.place, size: 40, color: Colors.white),
                              SizedBox(height: 12),
                              Text(
                                'Bank Sampah',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: buttonStyleInactive,
                          onPressed: () => _navigateTo(1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                size: 40,
                                color: Colors.black,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Request Pickup',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: buttonStyleActive,
                          onPressed: () => _navigateTo(2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.article_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Edukasi Sampah',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: buttonStyleInactive,
                          onPressed: () => _navigateTo(3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history_outlined,
                                size: 40,
                                color: Colors.black,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Riwayat Pickup',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Search bar di bawah tombol
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.grey.shade100,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  decoration: InputDecoration(
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
          ),
        ),
      ),
    );
  }
}
