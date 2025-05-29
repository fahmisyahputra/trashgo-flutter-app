import 'dart:async';
import 'package:flutter/material.dart';
import 'models/pickup_request.dart';

class PickupRequestProvider extends ChangeNotifier {
  final List<PickupRequest> _requests = [];

  List<PickupRequest> get requests => List.unmodifiable(_requests);

  void addRequest(PickupRequest request) {
    _requests.insert(0, request);
    notifyListeners();

    // Simulasi update status otomatis setelah submit
    _simulateStatusProgression(request);
  }

  void _simulateStatusProgression(PickupRequest request) {
    int index = _requests.indexOf(request);

    // Setelah 10 detik ubah ke SedangDiproses
    Timer(Duration(seconds: 10), () {
      if (index >= 0 && index < _requests.length) {
        _requests[index].status = StatusPickup.SedangDiproses;
        notifyListeners();

        // Setelah 10 detik lagi ubah ke Selesai
        Timer(Duration(seconds: 10), () {
          if (index >= 0 && index < _requests.length) {
            _requests[index].status = StatusPickup.Selesai;
            notifyListeners();
          }
        });
      }
    });
  }

  // Fungsi update status manual (jika diperlukan, tapi jangan dipanggil user)
  void updateStatus(int index, StatusPickup status) {
    if (index >= 0 && index < _requests.length) {
      _requests[index].status = status;
      notifyListeners();
    }
  }
}
