import 'package:flutter/material.dart';
import '../widgets/appbar_navbar.dart';
import '../models/edukasi_artikel.dart';
import 'artikel_detail_page.dart'; // Import halaman detail

class EdukasiSampahPage extends StatelessWidget {
  const EdukasiSampahPage({super.key});

  // Data artikel edukasi - menggunakan nama file yang sesuai dengan yang ada di folder
  List<EdukasiArtikel> get artikelList => [
    EdukasiArtikel(
      judul: "Cara Memilah Sampah Dengan Mudah",
      deskripsiSingkat: "Memilah sampah sebenarnya tidak sulit jika kita tahu caranya dan membiasakannya dalam kehidupan sehari-hari. Langkah pertama adalah mengenali jenis-jenis sampah, yaitu sampah organik, anorganik, dan B3 (bahan berbahaya dan beracun). Sampah organik seperti sisa makanan dan daun dapat dijadikan kompos, sedangkan sampah anorganik seperti plastik, kertas, dan kaleng bisa didaur ulang. Sementara itu, sampah B3 seperti baterai dan obat kedaluwarsa harus dibuang di tempat khusus. Gunakan wadah terpisah untuk setiap jenis sampah dan biasakan seluruh anggota keluarga untuk membuang sampah sesuai jenisnya. Dengan memilah sampah secara benar, kita tidak hanya membantu mengurangi pencemaran lingkungan, tetapi juga mendukung proses daur ulang dan menjaga kesehatan masyarakat.",
      imageUrl: "assets/images/edukasi1.jpg", // Sesuai dengan file yang ada
    ),
    EdukasiArtikel(
      judul: "7 Manfaat Daur Ulang Sampah",
      deskripsiSingkat: "Pelajari berbagai manfaat penting dari mendaur ulang sampah untuk lingkungan dan kehidupan sehari-hari. Mulai dari mengurangi polusi hingga menghemat energi...",
      imageUrl: "assets/images/edukasi2.jpg", // Sesuai dengan file yang ada
    ),
    EdukasiArtikel(
      judul: "Sampah Organik vs Anorganik",
      deskripsiSingkat: "Sampah organik dan anorganik adalah dua jenis sampah utama yang perlu kita kenali untuk mempermudah proses pemilahan dan pengelolaan sampah. Sampah organik berasal dari bahan alami yang mudah terurai secara biologis, seperti sisa makanan, daun kering, dan kulit buah. Sampah jenis ini dapat dimanfaatkan kembali, misalnya sebagai kompos untuk menyuburkan tanaman. Sementara itu, sampah anorganik berasal dari bahan non-alami atau bahan yang sulit terurai, seperti plastik, kaca, kaleng, dan styrofoam. Sampah anorganik umumnya bisa didaur ulang menjadi barang baru yang berguna, namun membutuhkan proses khusus. Memahami perbedaan antara sampah organik dan anorganik sangat penting agar kita bisa lebih bijak dalam mengelola sampah serta turut menjaga kebersihan dan kelestarian lingkungan.",
      imageUrl: "assets/images/edukasi1.jpg", // Menggunakan gambar yang ada
    ),
    EdukasiArtikel(
      judul: "Tips Mengurangi Sampah Plastik",
      deskripsiSingkat: "Sampah plastik menjadi masalah serius bagi lingkungan. Temukan cara-cara praktis untuk mengurangi penggunaan plastik dalam kehidupan sehari-hari...",
      imageUrl: "assets/images/edukasi2.jpg", // Menggunakan gambar yang ada
    ),
    EdukasiArtikel(
      judul: "Kompos dari Sampah Dapur",
      deskripsiSingkat: "Ubah sampah organik dari dapur menjadi kompos berkualitas tinggi. Panduan lengkap membuat kompos sederhana di rumah dengan bahan-bahan yang mudah didapat...",
      imageUrl: "assets/images/edukasi1.jpg", // Menggunakan gambar yang ada
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrashGoAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Edukasi Daur Ulang Sampah',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            
            // Articles List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: artikelList.length,
                itemBuilder: (context, index) {
                  final artikel = artikelList[index];
                  return _buildArtikelCard(context, artikel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtikelCard(BuildContext context, EdukasiArtikel artikel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.3),
                    Colors.blue.withOpacity(0.3),
                    Colors.yellow.withOpacity(0.3),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Gambar asli dengan debugging
                  Image.asset(
                    artikel.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      // Print error untuk debugging
                      print('Error loading image: ${artikel.imageUrl}');
                      print('Error: $error');
                      return _buildPlaceholderImage();
                    },
                  ),
                  
                  // Metode 2: Jika masih error, coba dengan path absolut
                  // Image.asset(
                  //   'assets/images/edukasi1.jpg', // hardcode untuk testing
                  //   fit: BoxFit.cover,
                  //   width: double.infinity,
                  //   height: double.infinity,
                  //   errorBuilder: (context, error, stackTrace) {
                  //     print('Hardcoded image also failed to load');
                  //     return _buildPlaceholderImage();
                  //   },
                  // ),
                  
                  // Gradient overlay
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  artikel.judul,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Description
                Text(
                  artikel.deskripsiSingkat,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                
                // Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToArtikel(context, artikel);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Lihat Artikel',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.3),
            Colors.blue.withOpacity(0.3),
            Colors.yellow.withOpacity(0.3),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Icon(
        Icons.recycling,
        size: 60,
        color: Colors.green[600],
      ),
    );
  }

  void _navigateToArtikel(BuildContext context, EdukasiArtikel artikel) {
    // Navigate to article detail page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArtikelDetailPage(artikel: artikel),
      ),
    );
  }
}