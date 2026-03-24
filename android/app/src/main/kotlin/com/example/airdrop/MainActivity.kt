package com.example.airdrop

import android.bluetooth.*
import android.bluetooth.le.*
import android.content.Context
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.*
import java.util.*

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.shareapp/channel"
    private val EVENT_CHANNEL = "com.example.shareapp/events"

    private var eventSink: EventChannel.EventSink? = null

    private lateinit var bluetoothAdapter: BluetoothAdapter
    private lateinit var scanner: BluetoothLeScanner

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        bluetoothAdapter = bluetoothManager.adapter
        scanner = bluetoothAdapter.bluetoothLeScanner

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "startDiscovery" -> {
                        startBleScan()
                        result.success(null)
                    }
                    "sendFile" -> {
                        // For now, we'll just acknowledge the call
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            })
    }

    private fun startBleScan() {
        val scanCallback = object : ScanCallback() {
            override fun onScanResult(callbackType: Int, result: ScanResult) {
                val device = result.device
                val name = device.name ?: "Unknown Device"

                val map = HashMap<String, Any>()
                map["id"] = device.address
                map["name"] = name
                map["rssi"] = result.rssi

                runOnUiThread {
                    eventSink?.success(map)
                }
            }

            override fun onScanFailed(errorCode: Int) {
                // Handle scan failure
            }
        }

        scanner.startScan(scanCallback)
    }
}
