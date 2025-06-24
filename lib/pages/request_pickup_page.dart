import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pickup_request.dart';
import '../pickup_request_provider.dart';
import '../widgets/appbar_navbar.dart'; 

class RequestPickupPage extends StatefulWidget {
  @override
  _RequestPickupPageState createState() => _RequestPickupPageState();
}

class _RequestPickupPageState extends State<RequestPickupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _weightController = TextEditingController();

  String selectedWasteType = 'Organik';
  final List<String> wasteTypes = ['Organik', 'Plastik', 'Kertas', 'Logam'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrashGoAppBar(), 
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul halaman
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text(
                  'Form Request Pickup',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Body Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildTextField(_nameController, "Nama Lengkap", "Nama...", required: true),
                        const SizedBox(height: 12),
                        _buildTextField(_addressController, "Alamat Penjemputan", "Alamat...", required: true),
                        const SizedBox(height: 12),
                        _buildWasteTypeSelector(),
                        const SizedBox(height: 12),
                        _buildTextField(_weightController, "Estimasi Berat Sampah", "Berat ... kg",
                            isNumber: true, required: true),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text("Submit", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint,
      {bool isNumber = false, bool required = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
          validator: required
              ? (value) {
                  if (value == null || value.isEmpty) return '$label wajib diisi';
                  if (isNumber) {
                    final berat = double.tryParse(value);
                    if (berat == null || berat <= 0) return 'Masukkan berat valid';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildWasteTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pilih Jenis Sampah", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: wasteTypes.map((type) {
              final isSelected = selectedWasteType == type;
              return GestureDetector(
                onTap: () => setState(() => selectedWasteType = type),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green[800] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    type,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<PickupRequestProvider>(context, listen: false);
      provider.addRequest(
        PickupRequest(
          tanggal: DateTime.now(),
          namaLengkap: _nameController.text,
          alamatPickup: _addressController.text,
          jenisSampah: selectedWasteType,
          beratSampah: _weightController.text,
          status: StatusPickup.MenungguKonfirmasi,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request berhasil dikirim!')),
      );

      _formKey.currentState!.reset();
      setState(() => selectedWasteType = 'Organik');
    }
  }
}
