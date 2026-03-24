class Device {
  final String id;
  final String name;
  final int rssi;

  Device({
    required this.id,
    required this.name,
    required this.rssi,
  });

  factory Device.fromMap(Map<dynamic, dynamic> map) {
    return Device(
      id: map['id'],
      name: map['name'],
      rssi: map['rssi'],
    );
  }
}
