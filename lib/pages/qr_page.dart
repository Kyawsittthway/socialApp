import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:untitled/utils/extensions.dart' as util;

import 'package:untitled/pages/contact_page.dart';

class QrPage extends StatefulWidget {
  QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 4,
        child: _buildQrView(context),
      ),
      Visibility(
        visible: (result != null) ? true : false,
        child: Container(
          child: Text(
            "Scan Complete!",
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 32,
            ),
          ),
        ),
      ),
      Visibility(
        visible: (result != null) ? true : false,
        child: Container(
          child: ElevatedButton(
            child: Text("Continue"),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ContactPage(exposedUserId: result!.code,)),
                  (Route<dynamic> route) => route is ContactPage);
            },
          ),
        ),
      )
    ]);
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        print("Result is :: ${result!.code}");
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 180.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: scanArea,
        borderColor: Colors.blue,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }
}
