import 'package:flutter/material.dart';
import 'models/pickup_request.dart';

class PickupRequestProvider extends ChangeNotifier {
  final List<PickupRequest> _requests = [];

  List<PickupRequest> get requests => List.unmodifiable(_requests);

  void addRequest(PickupRequest request) {
    _requests.insert(0, request);
    notifyListeners();
  }

  // Fungsi update status manual (digunakan admin)
  void updateStatus(int index, StatusPickup status) {
    if (index >= 0 && index < _requests.length) {
      _requests[index].status = status;
      notifyListeners();
    }
  }
}
