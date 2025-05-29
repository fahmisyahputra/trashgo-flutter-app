import 'package:flutter/material.dart';
import '../models/bank_sampah.dart';

class BankSampahPage extends StatefulWidget {
  final String? searchQuery;

  const BankSampahPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  State<BankSampahPage> createState() => _BankSampahPageState();
}

class _BankSampahPageState extends State<BankSampahPage> {
  final List<BankSampah> bankSampahList = [
    BankSampah(
      nama: 'Bank Sampah Sukolilo',
      alamat: 'Jl. Sukolilo No. 15, Surabaya, Jawa Timur',
      jarakKm: 1.2,
      imageUrl: 'assets/images/bank_sampah1.jpg',
    ),
    BankSampah(
      nama: 'Bank Sampah Semolowaru',
      alamat: 'Jl. Semolowaru No. 55, Surabaya, Jawa Timur',
      jarakKm: 2.5,
      imageUrl: 'assets/images/bank_sampah2.jpg',
    ),
  ];

  late String searchQuery;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.searchQuery ?? '';
    _controller = TextEditingController(text: searchQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = bankSampahList
        .where(
          (bank) => bank.nama.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green[700],
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
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black87),
            onPressed: () {
              // TODO: Open menu drawer or other actions
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.grey.shade100,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _controller,
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
                ),
              ),

              SizedBox(height: 12),

              // List bank sampah
              Expanded(
                child: filteredList.isEmpty
                    ? Center(child: Text('Bank Sampah tidak ditemukan'))
                    : ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final bank = filteredList[index];
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
                                      bank.imageUrl,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    bank.nama,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(bank.alamat),
                                  SizedBox(height: 4),
                                  Text(
                                    '${bank.jarakKm.toStringAsFixed(1)} KM dari kamu',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                      foregroundColor: Colors
                                          .white, // ini supaya teks & ikon putih
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      // TODO: buka maps lokasi bank sampah
                                    },
                                    icon: Icon(Icons.location_on_outlined),
                                    label: Text('Lihat Maps Lokasi'),
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
