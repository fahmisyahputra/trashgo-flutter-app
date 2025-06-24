import 'package:flutter/material.dart';
import '../models/edukasi_artikel.dart';

class ArtikelDetailPage extends StatelessWidget {
  final EdukasiArtikel artikel;

  const ArtikelDetailPage({
    super.key,
    required this.artikel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar dengan gambar
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: Colors.green[600],
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => _shareArtikel(context),
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => _bookmarkArtikel(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.asset(
                    artikel.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green[400]!,
                              Colors.green[600]!,
                              Colors.green[800]!,
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.recycling,
                          size: 80,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      );
                    },
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      artikel.judul,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Meta Info
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '5 min read',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.visibility,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '1.2k views',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Content
                    _buildArticleContent(),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Introduction
        Text(
          artikel.deskripsiSingkat,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.6,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 24),
        
        // Main Content - generate based on article title
        ..._generateContentByTitle(artikel.judul),
      ],
    );
  }

  List<Widget> _generateContentByTitle(String judul) {
    if (judul.contains("Memilah Sampah")) {
      return _buildMemilahSampahContent();
    } else if (judul.contains("Manfaat Daur Ulang")) {
      return _buildManfaatDaurUlangContent();
    } else if (judul.contains("Organik vs Anorganik")) {
      return _buildOrganikAnorganikContent();
    } else if (judul.contains("Mengurangi Sampah Plastik")) {
      return _buildTipsPlastikContent();
    } else if (judul.contains("Kompos")) {
      return _buildKomposContent();
    } else {
      return _buildDefaultContent();
    }
  }

  List<Widget> _buildMemilahSampahContent() {
    return [
      _buildSectionTitle("Mengapa Memilah Sampah Penting?"),
      _buildParagraph("Memilah sampah adalah langkah awal yang paling penting dalam pengelolaan sampah yang berkelanjutan. Dengan memilah sampah dengan benar, kita dapat mengurangi volume sampah yang berakhir di tempat pembuangan akhir."),
      
      _buildSectionTitle("Jenis-Jenis Sampah"),
      _buildBulletPoint("Sampah Organik", "Sisa makanan, daun, ranting, dan bahan alami lainnya"),
      _buildBulletPoint("Sampah Anorganik", "Plastik, kertas, logam, dan kaca"),
      _buildBulletPoint("Sampah B3", "Baterai, lampu, obat-obatan, dan bahan berbahaya"),
      
      _buildSectionTitle("Cara Memilah yang Benar"),
      _buildNumberedPoint("1", "Siapkan 3 tempat sampah dengan warna berbeda"),
      _buildNumberedPoint("2", "Pisahkan sampah basah (organik) dan kering (anorganik)"),
      _buildNumberedPoint("3", "Bersihkan wadah plastik sebelum dibuang"),
      _buildNumberedPoint("4", "Simpan sampah berbahaya secara terpisah"),
    ];
  }

  List<Widget> _buildManfaatDaurUlangContent() {
    return [
      _buildSectionTitle("7 Manfaat Utama Daur Ulang"),
      _buildNumberedPoint("1", "Mengurangi polusi udara dan air"),
      _buildNumberedPoint("2", "Menghemat sumber daya alam"),
      _buildNumberedPoint("3", "Mengurangi emisi gas rumah kaca"),
      _buildNumberedPoint("4", "Menciptakan lapangan kerja baru"),
      _buildNumberedPoint("5", "Menghemat energi"),
      _buildNumberedPoint("6", "Mengurangi volume sampah di TPA"),
      _buildNumberedPoint("7", "Menghasilkan produk baru yang berguna"),
      
      _buildSectionTitle("Dampak Positif untuk Lingkungan"),
      _buildParagraph("Daur ulang dapat mengurangi hingga 70% polusi udara dan 35% polusi air. Selain itu, proses daur ulang menggunakan energi yang jauh lebih sedikit dibandingkan membuat produk baru dari bahan mentah."),
    ];
  }

  List<Widget> _buildOrganikAnorganikContent() {
    return [
      _buildSectionTitle("Sampah Organik"),
      _buildParagraph("Sampah organik adalah sampah yang berasal dari makhluk hidup dan dapat terurai secara alami oleh mikroorganisme."),
      _buildBulletPoint("Contoh", "Sisa makanan, daun, buah busuk, sayuran"),
      _buildBulletPoint("Karakteristik", "Mudah membusuk, berbau, dapat dijadikan kompos"),
      
      _buildSectionTitle("Sampah Anorganik"),
      _buildParagraph("Sampah anorganik adalah sampah yang tidak dapat terurai secara alami dan membutuhkan waktu yang sangat lama untuk hancur."),
      _buildBulletPoint("Contoh", "Plastik, logam, kaca, kertas"),
      _buildBulletPoint("Karakteristik", "Tidak mudah membusuk, dapat didaur ulang"),
    ];
  }

  List<Widget> _buildTipsPlastikContent() {
    return [
      _buildSectionTitle("Tips Mengurangi Sampah Plastik"),
      _buildNumberedPoint("1", "Gunakan tas belanja yang dapat digunakan kembali"),
      _buildNumberedPoint("2", "Bawa botol minum sendiri"),
      _buildNumberedPoint("3", "Hindari penggunaan sedotan plastik"),
      _buildNumberedPoint("4", "Pilih produk dengan kemasan minimal"),
      _buildNumberedPoint("5", "Gunakan wadah kaca untuk menyimpan makanan"),
      
      _buildSectionTitle("Alternatif Pengganti Plastik"),
      _buildParagraph("Ada banyak alternatif ramah lingkungan yang dapat menggantikan plastik dalam kehidupan sehari-hari."),
    ];
  }

  List<Widget> _buildKomposContent() {
    return [
      _buildSectionTitle("Cara Membuat Kompos Sederhana"),
      _buildNumberedPoint("1", "Siapkan wadah komposter atau ember berlubang"),
      _buildNumberedPoint("2", "Kumpulkan sampah organik dari dapur"),
      _buildNumberedPoint("3", "Campurkan dengan tanah dan dedaunan kering"),
      _buildNumberedPoint("4", "Aduk secara teratur setiap 3-4 hari"),
      _buildNumberedPoint("5", "Tunggu 2-3 bulan hingga menjadi kompos matang"),
      
      _buildSectionTitle("Manfaat Kompos"),
      _buildParagraph("Kompos yang dihasilkan dapat digunakan sebagai pupuk alami untuk tanaman, mengurangi kebutuhan pupuk kimia, dan menyuburkan tanah."),
    ];
  }

  List<Widget> _buildDefaultContent() {
    return [
      _buildParagraph("Artikel ini membahas pentingnya pengelolaan sampah yang baik untuk menjaga kelestarian lingkungan. Setiap individu memiliki peran penting dalam menciptakan lingkungan yang bersih dan sehat."),
      _buildParagraph("Dengan memahami dan menerapkan prinsip-prinsip pengelolaan sampah yang benar, kita dapat berkontribusi dalam menjaga keberlanjutan lingkungan untuk generasi mendatang."),
    ];
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green[700],
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
          height: 1.6,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildBulletPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 12),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.green[600],
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedPoint(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.green[600],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareArtikel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Artikel "${artikel.judul}" dibagikan!'),
        backgroundColor: Colors.green[600],
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _bookmarkArtikel(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Artikel "${artikel.judul}" disimpan!'),
        backgroundColor: Colors.blue[600],
        duration: Duration(seconds: 2),
      ),
    );
  }
}