import 'package:flutter/material.dart';
import 'device_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Universal Share")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DeviceListScreen(),
              ),
            );
          },
          child: const Text("Send File"),
        ),
      ),
    );
  }
}
