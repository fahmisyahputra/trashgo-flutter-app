import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pickup_request.dart';
import '../pickup_request_provider.dart';
import 'package:intl/intl.dart';
import '../widgets/appbar_navbar.dart';

class RiwayatPickupPage extends StatefulWidget {
  @override
  State<RiwayatPickupPage> createState() => _RiwayatPickupPageState();
}

class _RiwayatPickupPageState extends State<RiwayatPickupPage> {
  late List<PickupRequest> _filteredRiwayat;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final allRiwayat = Provider.of<PickupRequestProvider>(
      context,
      listen: false,
    ).requests;
    _filteredRiwayat = allRiwayat;
  }

  Color statusColor(StatusPickup status) {
    switch (status) {
      case StatusPickup.MenungguKonfirmasi:
        return Colors.red.shade700;
      case StatusPickup.SedangDiproses:
        return Colors.yellow.shade700;
      case StatusPickup.Selesai:
        return Colors.green.shade700;
      default:
        return Colors.grey;
    }
  }

  String statusText(StatusPickup status) {
    switch (status) {
      case StatusPickup.MenungguKonfirmasi:
        return 'Status : Menunggu Konfirmasi';
      case StatusPickup.SedangDiproses:
        return 'Status : Sedang Diproses';
      case StatusPickup.Selesai:
        return 'Status : Selesai';
      default:
        return '';
    }
  }

  void _handleSearch(String query, List<PickupRequest> allRiwayat) {
    setState(() {
      _searchQuery = query;
      _filteredRiwayat = allRiwayat.where((item) {
        final data = [
          item.namaLengkap.toLowerCase(),
          item.alamatPickup.toLowerCase(),
          item.jenisSampah.toLowerCase(),
        ];
        return data.any((field) => field.contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'id_ID');
    final pickupProvider = Provider.of<PickupRequestProvider>(context);
    final allRiwayat = pickupProvider.requests;

    return Scaffold(
      appBar: TrashGoAppBar(), // Ganti dengan reusable AppBar
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Judul
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Riwayat Pickup Kamu...',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),

              // Search Bar
              Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.grey.shade100,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Riwayat...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                  onChanged: (val) => _handleSearch(val, allRiwayat),
                ),
              ),

              // List Riwayat
              Expanded(
                child: _filteredRiwayat.isEmpty
                    ? Center(child: Text('Tidak ada riwayat ditemukan.'))
                    : ListView.builder(
                        itemCount: _filteredRiwayat.length,
                        itemBuilder: (context, index) {
                          final item = _filteredRiwayat[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.only(bottom: 14),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dateFormatter.format(item.tanggal),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(item.namaLengkap),
                                  SizedBox(height: 10),
                                  Text(item.alamatPickup),
                                  SizedBox(height: 10),
                                  Text('Jenis Sampah: ${item.jenisSampah}'),
                                  SizedBox(height: 10),
                                  Text('Berat: ${item.beratSampah} kg'),
                                  SizedBox(height: 12),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: statusColor(item.status),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      statusText(item.status),
                                      style: TextStyle(color: Colors.white),
                                    ),
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
