import 'package:flutter/material.dart';
import '../models/device.dart';
import '../services/platform_service.dart';
import '../services/file_service.dart';
import 'transfer_screen.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  List<Device> devices = [];

  @override
  void initState() {
    super.initState();
    startDiscovery();
  }

  void startDiscovery() async {
    await PlatformService.startDiscovery();

    PlatformService.deviceStream.listen((event) {
      final device = Device.fromMap(Map.from(event));

      setState(() {
        devices.removeWhere((d) => d.id == device.id);
        devices.add(device);
      });
    });
  }

  void sendFile(Device device) async {
    final path = await FileService.pickFile();
    if (path == null) return;

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransferScreen(
          device: device,
          filePath: path,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Devices")),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (_, index) {
          final device = devices[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text("Signal: ${device.rssi}"),
            onTap: () => sendFile(device),
          );
        },
      ),
    );
  }
}
