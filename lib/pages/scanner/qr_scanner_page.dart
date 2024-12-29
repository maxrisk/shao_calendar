import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// 二维码扫描页面
class QRScannerPage extends StatefulWidget {
  /// 创建二维码扫描页面
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with WidgetsBindingObserver {
  late MobileScannerController controller;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        controller.start();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        controller.stop();
        break;
      case AppLifecycleState.detached:
        controller.dispose();
        break;
      default:
        break;
    }
  }

  Future<void> _toggleFlash() async {
    try {
      await controller.toggleTorch();
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('闪光灯控制失败')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫描二维码'),
        actions: [
          IconButton(
            icon: Icon(_isFlashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: _toggleFlash,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && mounted) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  controller.stop();
                  Navigator.of(context).pop(code);
                }
              }
            },
            errorBuilder: (context, error, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '相机初始化失败: ${error.errorCode}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox.expand(
            child: CustomPaint(
              painter: ScannerOverlay(
                borderColor: Theme.of(context).primaryColor,
                overlayColor: Colors.black54,
                scannerSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: const Text(
              '将二维码放入框内，即可自动扫描',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 扫描框绘制
class ScannerOverlay extends CustomPainter {
  ScannerOverlay({
    required this.borderColor,
    required this.overlayColor,
    required this.scannerSize,
  });

  final Color borderColor;
  final Color overlayColor;
  final double scannerSize;

  @override
  void paint(Canvas canvas, Size size) {
    final double scanAreaLeft = (size.width - scannerSize) / 2;
    final double scanAreaTop = (size.height - scannerSize) / 2;

    final Paint overlayPaint = Paint()..color = overlayColor;
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // 绘制遮罩
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                scanAreaLeft,
                scanAreaTop,
                scannerSize,
                scannerSize,
              ),
              const Radius.circular(12),
            ),
          ),
      ),
      overlayPaint,
    );

    // 绘制边框
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          scanAreaLeft,
          scanAreaTop,
          scannerSize,
          scannerSize,
        ),
        const Radius.circular(12),
      ),
      borderPaint,
    );

    // 绘制四角
    final double cornerSize = 20;
    final Paint cornerPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    // 左上角
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + cornerSize),
      Offset(scanAreaLeft, scanAreaTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop),
      Offset(scanAreaLeft + cornerSize, scanAreaTop),
      cornerPaint,
    );

    // 右上角
    canvas.drawLine(
      Offset(scanAreaLeft + scannerSize - cornerSize, scanAreaTop),
      Offset(scanAreaLeft + scannerSize, scanAreaTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + scannerSize, scanAreaTop),
      Offset(scanAreaLeft + scannerSize, scanAreaTop + cornerSize),
      cornerPaint,
    );

    // 右下角
    canvas.drawLine(
      Offset(
          scanAreaLeft + scannerSize, scanAreaTop + scannerSize - cornerSize),
      Offset(scanAreaLeft + scannerSize, scanAreaTop + scannerSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + scannerSize, scanAreaTop + scannerSize),
      Offset(
          scanAreaLeft + scannerSize - cornerSize, scanAreaTop + scannerSize),
      cornerPaint,
    );

    // 左下角
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + scannerSize - cornerSize),
      Offset(scanAreaLeft, scanAreaTop + scannerSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + scannerSize),
      Offset(scanAreaLeft + cornerSize, scanAreaTop + scannerSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
