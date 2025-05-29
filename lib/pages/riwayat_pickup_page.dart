import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pickup_request.dart';
import '../pickup_request_provider.dart';
import 'package:intl/intl.dart';

class RiwayatPickupPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'id_ID');
    final pickupProvider = Provider.of<PickupRequestProvider>(context);
    final riwayat = pickupProvider.requests;

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
              // TODO: menu action
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
                  'Riwayat Pickup Kamu...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: riwayat.length,
                  itemBuilder: (context, index) {
                    final item = riwayat[index];
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
                            Text(
                              dateFormatter.format(item.tanggal),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(item.namaLengkap),
                            Text(item.alamatPickup),
                            Text('Jenis Sampah: ${item.jenisSampah}'),
                            Text('Berat: ${item.beratSampah} kg'),
                            SizedBox(height: 8),
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
                            SizedBox(height: 8),
                            // Contoh tombol update status, hanya untuk demo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PopupMenuButton<StatusPickup>(
                                  onSelected: (newStatus) {
                                    pickupProvider.updateStatus(index, newStatus);
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: StatusPickup.MenungguKonfirmasi,
                                      child: Text('Menunggu Konfirmasi'),
                                    ),
                                    PopupMenuItem(
                                      value: StatusPickup.SedangDiproses,
                                      child: Text('Sedang Diproses'),
                                    ),
                                    PopupMenuItem(
                                      value: StatusPickup.Selesai,
                                      child: Text('Selesai'),
                                    ),
                                  ],
                                  child: Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12),
              Container(
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
                  onChanged: (val) {
                    // TODO: Implement search filtering
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
