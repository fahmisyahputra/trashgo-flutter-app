import 'package:flutter/material.dart';
import '../widgets/appbar_navbar.dart';

class RequestPickupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrashGoAppBar(), // Ganti dengan reusable AppBar
      body: SafeArea(
        child: Center(
          child: Text(
            'Hello World! This is the Request Pickup Page.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
