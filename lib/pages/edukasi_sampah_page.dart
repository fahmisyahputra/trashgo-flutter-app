import 'package:flutter/material.dart';
import '../widgets/appbar_navbar.dart';

class EdukasiSampahPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrashGoAppBar(),
      body: SafeArea(
        child: Center(
          child: Text(
            'Hello World! This is the Edukasi Sampah Page.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
