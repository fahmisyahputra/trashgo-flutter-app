enum StatusPickup { MenungguKonfirmasi, SedangDiproses, Selesai }

class PickupRequest {
  DateTime tanggal;
  String namaLengkap;
  String alamatPickup;
  String jenisSampah;
  String beratSampah;
  StatusPickup status;

  PickupRequest({
    required this.tanggal,
    required this.namaLengkap,
    required this.alamatPickup,
    required this.jenisSampah,
    required this.beratSampah,
    this.status = StatusPickup.MenungguKonfirmasi,
  });
}
