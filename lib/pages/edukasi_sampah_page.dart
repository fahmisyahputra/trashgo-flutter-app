import 'package:flutter/material.dart';
import '../models/edukasi_artikel.dart';

class EdukasiSampahPage extends StatelessWidget {
  final List<EdukasiArtikel> artikelList = [
    EdukasiArtikel(
      judul: 'Cara Memilah Sampah Dengan Mudah',
      deskripsiSingkat:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      imageUrl: 'assets/images/edukasi1.jpg',
    ),
    EdukasiArtikel(
      judul: '7 Manfaat Daur Ulang Sampah',
      deskripsiSingkat:
          'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
      imageUrl: 'assets/images/edukasi2.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.delete_outline, color: Colors.green[700]),
            SizedBox(width: 8),
            Text(
              'TrashGo',
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
            icon: Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              // TODO: Open menu drawer or actions
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Edukasi Daur Ulang Sampah',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: artikelList.length,
                  itemBuilder: (context, index) {
                    final artikel = artikelList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                artikel.imageUrl,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              artikel.judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(artikel.deskripsiSingkat),
                            SizedBox(height: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // TODO: buka artikel detail
                              },
                              child: Text('Lihat Artikel'),
                            ),
                          ],
                        ),
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
