import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScannerApp extends StatefulWidget {
  const QRScannerApp({super.key});

  @override
  State<QRScannerApp> createState() => _QRScannerAppState();
}

class _QRScannerAppState extends State<QRScannerApp> {
  Barcode? scanResult;
  QRViewController? qrViewController;
  GlobalKey globalKey = GlobalKey(debugLabel: "QR");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(child: _buildQRView(context))
    );
  }

  Widget _buildQRView(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var scanArea = (size.height < 400 || size.height < 400) ? 150.0 : 300.0;
    return QRView(
      key: globalKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.deepPurpleAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (controller, isAllowed) =>
          _onPermissionSet(context, controller, isAllowed),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => qrViewController = controller);
    controller.scannedDataStream.listen((scanData) => setState(() {
          scanResult = scanData;
        }));
  }

  void _onPermissionSet(
      BuildContext context, QRViewController controller, bool isAllowed) {
    if (!isAllowed) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }
}
