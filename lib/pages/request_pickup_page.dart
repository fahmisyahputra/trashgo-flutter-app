import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pickup_request.dart';
import '../pickup_request_provider.dart';

class RequestPickupPage extends StatefulWidget {
  @override
  State<RequestPickupPage> createState() => _RequestPickupPageState();
}

class _RequestPickupPageState extends State<RequestPickupPage> {
  final _formKey = GlobalKey<FormState>();
  String? namaLengkap;
  String? alamatPickup;
  String jenisSampah = 'Organik';
  String? beratSampah;

  final List<String> jenisSampahList = [
    'Organik',
    'Plastik',
    'Kertas',
    'Logam',
  ];

  @override
  Widget build(BuildContext context) {
    final pickupProvider = Provider.of<PickupRequestProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Form Request Pickup'),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Form Request Pickup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 16),

                Text('Nama Lengkap', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nama...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                  onSaved: (val) => namaLengkap = val,
                ),
                SizedBox(height: 16),

                Text('Alamat Penjemputan', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Alamat...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat wajib diisi';
                    }
                    return null;
                  },
                  onSaved: (val) => alamatPickup = val,
                ),
                SizedBox(height: 16),

                Text('Pilih Jenis Sampah', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: jenisSampahList.map((jenis) {
                    final selected = jenis == jenisSampah;
                    return ChoiceChip(
                      label: Text(jenis),
                      selected: selected,
                      selectedColor: Colors.green[700],
                      onSelected: (_) {
                        setState(() {
                          jenisSampah = jenis;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                Text('Estimasi Berat Sampah (kg)', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Berat ... kg',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Estimasi berat wajib diisi';
                    }
                    final berat = double.tryParse(value);
                    if (berat == null || berat <= 0) {
                      return 'Masukkan berat valid';
                    }
                    return null;
                  },
                  onSaved: (val) => beratSampah = val,
                ),
                SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      pickupProvider.addRequest(
                        PickupRequest(
                          tanggal: DateTime.now(),
                          namaLengkap: namaLengkap!,
                          alamatPickup: alamatPickup!,
                          jenisSampah: jenisSampah,
                          beratSampah: beratSampah!,
                          status: StatusPickup.MenungguKonfirmasi,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Request berhasil dikirim!')),
                      );

                      _formKey.currentState!.reset();
                      setState(() {
                        jenisSampah = 'Organik';
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
