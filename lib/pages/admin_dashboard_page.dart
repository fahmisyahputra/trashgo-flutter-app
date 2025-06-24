import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pickup_request.dart';
import '../pickup_request_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/appbar_navbar.dart';
import 'package:intl/intl.dart';

class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final pickupProvider = Provider.of<PickupRequestProvider>(context);
    final dateFormatter = DateFormat('d MMMM yyyy, HH:mm', 'id_ID');

    if (auth.role != 'admin') {
      return Scaffold(
        appBar: TrashGoAppBar(),
        body: Center(
          child: Text('Halaman ini hanya bisa diakses oleh admin.'),
        ),
      );
    }

    return Scaffold(
      appBar: TrashGoAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: pickupProvider.requests.length,
          itemBuilder: (context, index) {
            final request = pickupProvider.requests[index];

            return Card(
              margin: EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateFormatter.format(request.tanggal),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Nama: ${request.namaLengkap}'),
                    Text('Alamat: ${request.alamatPickup}'),
                    Text('Jenis Sampah: ${request.jenisSampah}'),
                    Text('Berat: ${request.beratSampah} kg'),
                    SizedBox(height: 12),
                    Text('Status Saat Ini: ${statusText(request.status)}'),
                    SizedBox(height: 8),
                    Row(
                      children: StatusPickup.values.map((status) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              pickupProvider.updateStatus(index, status);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: statusColor(status),
                            ),
                            child: Text(statusText(status)),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String statusText(StatusPickup status) {
    switch (status) {
      case StatusPickup.MenungguKonfirmasi:
        return 'Menunggu';
      case StatusPickup.SedangDiproses:
        return 'Diproses';
      case StatusPickup.Selesai:
        return 'Selesai';
      default:
        return '';
    }
  }

  Color statusColor(StatusPickup status) {
    switch (status) {
      case StatusPickup.MenungguKonfirmasi:
        return Colors.red;
      case StatusPickup.SedangDiproses:
        return Colors.orange;
      case StatusPickup.Selesai:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
