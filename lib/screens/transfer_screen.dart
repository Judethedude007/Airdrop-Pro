import 'package:flutter/material.dart';
import '../models/device.dart';
import '../services/platform_service.dart';

class TransferScreen extends StatefulWidget {
  final Device device;
  final String filePath;

  const TransferScreen({
    super.key,
    required this.device,
    required this.filePath,
  });

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    startTransfer();
  }

  void startTransfer() async {
    await PlatformService.sendFile(
      widget.filePath,
      widget.device.id,
    );

    // Later: listen to progress updates from native
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sending to ${widget.device.name}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sending file..."),
            const SizedBox(height: 20),
            LinearProgressIndicator(value: progress),
            const SizedBox(height: 10),
            Text("${(progress * 100).toStringAsFixed(1)}%"),
          ],
        ),
      ),
    );
  }
}
