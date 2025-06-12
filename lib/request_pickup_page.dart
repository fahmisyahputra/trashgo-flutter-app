import 'package:flutter/material.dart';

class RequestPickupPage extends StatefulWidget {
  @override
  _RequestPickupPageState createState() => _RequestPickupPageState();
}

class _RequestPickupPageState extends State<RequestPickupPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _weightController = TextEditingController();

  String selectedWasteType = 'Organik';
  final List<String> wasteTypes = ['Organik', 'Plastik', 'Kertas', 'Logam'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan Logo dan Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'lib/assets/trashgo.png',
                    width: 130,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Judul form di bawah logo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Text(
                'Form Request Pickup',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Body form
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
                      _buildTextField(_nameController, "Nama Lengkap", "Nama..."),
                      const SizedBox(height: 12),
                      _buildTextField(_addressController, "Alamat Penjemputan", "Alamat..."),
                      const SizedBox(height: 12),
                      _buildWasteTypeSelector(),
                      const SizedBox(height: 12),
                      _buildTextField(_weightController, "Estimasi Berat Sampah", "Berat ... kg", isNumber: true),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Submit logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text("Submit",style: TextStyle(color: Colors.white),),                  
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Cari Bank Sampah"),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Request Pickup"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat Pickup"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Edukasi Sampah"),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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
      const Text(
        "Pilih Jenis Sampah",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
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
          childAspectRatio: 3, // lebar lebih besar dari tinggi
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
}
