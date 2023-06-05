import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<QRViewExample> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: isScanning ? null : _startScan,
            child: const Text('Start Scan'),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!isScanning) {
        setState(() {
          isScanning = true;
        });
        _processScannedData(scanData.code);
      }
    });
  }

  void _startScan() {
    setState(() {
      isScanning = true;
    });
    controller?.resumeCamera();
  }

  void _processScannedData(String? data) async {
    if (data != null) {
      await launchPaymentPage(data);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to scan the QR code.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> launchPaymentPage(String data) async {}
}
