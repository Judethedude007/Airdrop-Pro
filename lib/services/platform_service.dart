import 'package:flutter/services.dart';

class PlatformService {
  static const MethodChannel _channel =
      MethodChannel('com.example.shareapp/channel');

  /// Start scanning for nearby devices
  static Future<void> startDiscovery() async {
    await _channel.invokeMethod('startDiscovery');
  }

  /// Send file
  static Future<void> sendFile(String path, String deviceId) async {
    await _channel.invokeMethod('sendFile', {
      'path': path,
      'deviceId': deviceId,
    });
  }

  /// Listen for devices
  static const EventChannel _eventChannel =
      EventChannel('com.example.shareapp/events');

  static Stream<dynamic> get deviceStream {
    return _eventChannel.receiveBroadcastStream();
  }
}
