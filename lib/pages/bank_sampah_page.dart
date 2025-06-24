import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/bank_sampah.dart';
import '../widgets/appbar_navbar.dart'; 

class BankSampahPage extends StatefulWidget {
  final String? searchQuery;

  const BankSampahPage({Key? key, this.searchQuery}) : super(key: key);

  @override
  State<BankSampahPage> createState() => _BankSampahPageState();
}

class _BankSampahPageState extends State<BankSampahPage> {
  final List<BankSampah> bankSampahList = [
    BankSampah(
      nama: 'Bank Sampah Induk Surabaya',
      alamat:
          'Jl. Raya Menur No.31-A, Manyar Sabrangan, Kec. Mulyorejo, Surabaya, Jawa Timur',
      latitude: -7.277911093294131,
      longitude: 112.76407826964619,
      imageUrl: 'assets/images/bank_sampah1.jpg',
      mapsUrl: 'https://maps.app.goo.gl/AUWzL8uq2sAXGj8u8',
    ),
    BankSampah(
      nama: 'Bank Sampah Margorejo Mandiri',
      alamat:
          'Jl. Margorejo III G No.34, Margorejo, Kec. Wonocolo, Surabaya, Jawa Timur',
      latitude: -7.311012328685286,
      longitude: 112.74154159335161,
      imageUrl: 'assets/images/bank_sampah2.jpg',
      mapsUrl: 'https://maps.app.goo.gl/49UKdiFBDxXZCQsJ8',
    ),
    BankSampah(
      nama: 'Bank Sampah Manyar Mandiri',
      alamat:
          'Jl. Manyar Sabrangan IX B Gg. Makam, Manyar Sabrangan, Kec. Mulyorejo, Surabaya, Jawa Timur',
      latitude: -7.281551833465722,
      longitude: 112.77251362219201,
      imageUrl: 'assets/images/bank_sampah3.jpg',
      mapsUrl: 'https://maps.app.goo.gl/49UKdiFBDxXZCQsJ8',
    ),
    BankSampah(
      nama: 'Bank Sampah Bintang Mangrove',
      alamat:
          'Kawasan Mangrove, Gununganyar tambak gg. 3, Kec. Gn. Anyar, Surabaya, Jawa Timur',
      latitude: -7.340818271848959,
      longitude: 112.8344713299799,
      imageUrl: 'assets/images/bank_sampah4.jpg',
      mapsUrl: 'https://maps.app.goo.gl/a1KeeeEMqTivNdtq7',
    ),
    BankSampah(
      nama: 'Bank Sampah Seruni',
      alamat:
          'Jl. Bulak Cumpat Barat No.I, Bulak, Kec. Bulak, Surabaya, Jawa Timur',
      latitude: -7.230882287764537,
      longitude: 112.77529491802794,
      imageUrl: 'assets/images/bank_sampah5.jpg',
      mapsUrl: 'https://maps.app.goo.gl/yYriLh7DLc3JZv4N6',
    ),
    BankSampah(
      nama: 'Bank Sampah Masidosi 6',
      alamat:
          'Jl. Medokan Semampir No.17, RT.003/RW.03, Medokan Semampir, Kec. Sukolilo, Surabaya, Jawa Timur',
      latitude: -7.304070253175935,
      longitude: 112.80010612363789,
      imageUrl: 'assets/images/bank_sampah6.jpg',
      mapsUrl: 'https://maps.app.goo.gl/8cK6Geekw1UsPznQA',
    ),
    BankSampah(
      nama: 'Bank Sampah Srikandi Keputih',
      alamat:
          'Jl. Keputih Tegal Timur Baru II, Keputih, Kec. Sukolilo, Surabaya, Jawa Timur',
      latitude: -7.297408884255659,
      longitude: 112.8102731213677,
      imageUrl: 'assets/images/bank_sampah7.jpg',
      mapsUrl: 'https://maps.app.goo.gl/rdE1bw4U8QM2iyjM7',
    ),
    BankSampah(
      nama: 'Bank Sampah SAMAS',
      alamat:
          'Jl. Pandegiling No.312, Wonorejo, Kec. Tegalsari, Surabaya, Jawa Timur',
      latitude: -7.272493354028919,
      longitude: 112.73141171014493,
      imageUrl: 'assets/images/bank_sampah8.jpg',
      mapsUrl: 'https://maps.app.goo.gl/vPgRY8xC4GFoX5rR7',
    ),
    BankSampah(
      nama: 'Bank Sampah Teratai',
      alamat:
          'Jl. Rungkut Asri Barat IV No.14, Rungkut Kidul, Kec. Rungkut, Surabaya, Jawa Timur',
      latitude: -7.326338838679739,
      longitude: 112.77669718611409,
      imageUrl: 'assets/images/bank_sampah9.jpg',
      mapsUrl: 'https://maps.app.goo.gl/4g2iKP97vKnDzkEg9',
    ),
    BankSampah(
      nama: 'Bank Sampah Jatilondo',
      alamat:
          'Jl. Jatisrono IV No.12, RT.003/RW.14, Ujung, Kec. Semampir, Surabaya, Jawa Timur',
      latitude: -7.217365892180368,
      longitude: 112.75484015824541,
      imageUrl: 'assets/images/bank_sampah10.jpg',
      mapsUrl: 'https://maps.app.goo.gl/drywMLYcsD4uF7hm7',
    ),
  ];

  late String searchQuery;
  late TextEditingController _controller;
  Position? _userPosition;
  bool _locationPermissionDenied = false;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.searchQuery ?? '';
    _controller = TextEditingController(text: searchQuery);
    _determinePosition();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _locationPermissionDenied = true);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _locationPermissionDenied = true);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _locationPermissionDenied = true);
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _userPosition = position;
      _locationPermissionDenied = false;
    });
  }

  double? _calculateDistance(BankSampah bank) {
    if (_userPosition == null) return null;
    final distanceMeters = Geolocator.distanceBetween(
      _userPosition!.latitude,
      _userPosition!.longitude,
      bank.latitude,
      bank.longitude,
    );
    return distanceMeters / 1000;
  }

  Future<void> _launchMaps(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuka Google Maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<BankSampah> filteredList = bankSampahList
        .where((bank) =>
            bank.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (_userPosition != null) {
      filteredList.sort((a, b) {
        final jarakA = Geolocator.distanceBetween(
          _userPosition!.latitude,
          _userPosition!.longitude,
          a.latitude,
          a.longitude,
        );
        final jarakB = Geolocator.distanceBetween(
          _userPosition!.latitude,
          _userPosition!.longitude,
          b.latitude,
          b.longitude,
        );
        return jarakA.compareTo(jarakB);
      });
    }

    return Scaffold(
      appBar: TrashGoAppBar(), // GANTI INI
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
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
                  onChanged: (val) => setState(() => searchQuery = val),
                ),
              ),
              SizedBox(height: 12),
              if (_locationPermissionDenied)
                Text(
                  'Izin lokasi ditolak, jarak tidak bisa ditampilkan.',
                  style: TextStyle(color: Colors.red),
                ),
              Expanded(
                child: filteredList.isEmpty
                    ? Center(child: Text('Bank Sampah tidak ditemukan'))
                    : ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final bank = filteredList[index];
                          final distanceKm = _calculateDistance(bank);

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
                                    distanceKm != null
                                        ? '${distanceKm.toStringAsFixed(1)} KM dari kamu'
                                        : 'Menghitung jarak...',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[700],
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => _launchMaps(bank.mapsUrl),
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
