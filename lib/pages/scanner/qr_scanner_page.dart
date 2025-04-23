import 'package:flutter/material.dart';
import 'package:flutter_calendar/pages/profile/login_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import '../../utils/invite_code_util.dart';

/// 二维码扫描页面
class QRScannerPage extends StatefulWidget {
  /// 创建二维码扫描页面
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late MobileScannerController controller;
  bool _isFlashOn = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        controller.start();
        _animationController.repeat();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        controller.stop();
        _animationController.stop();
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
          const SnackBar(
            content: Text('闪光灯控制失败'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('扫描二维码'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
              color: _isFlashOn
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(8),
              minimumSize: const Size(44, 44),
            ),
            onPressed: _toggleFlash,
          ),
          const SizedBox(width: 8),
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

                  // 检测是否包含邀请码
                  final inviteCode = InviteCodeUtil.extractInviteCode(code);
                  if (inviteCode != null) {
                    // 检查用户是否已登录
                    if (userService.userInfo == null) {
                      // 用户未登录，保存邀请码并跳转登录页面
                      // 保存邀请码到 UserService
                      userService.setInviteCode(inviteCode);

                      // 显示提示
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('已保存邀请码: $inviteCode'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );

                      // 跳转至登录页面
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    } else {
                      // 用户已登录，显示提示并返回上一页
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('您已登录，无需填写邀请码'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.of(context).pop(code);
                    }
                  } else {
                    Navigator.of(context).pop(code);
                  }
                }
              }
            },
            errorBuilder: (context, error, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: colorScheme.error,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '相机初始化失败',
                      style: TextStyle(
                        color: colorScheme.error,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '错误代码: ${error.errorCode}',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // 扫描动画
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final screenWidth = MediaQuery.of(context).size.width;
              return Positioned(
                top: MediaQuery.of(context).size.height *
                        _animationController.value -
                    300,
                left: -screenWidth * 0.2,
                right: -screenWidth * 0.2,
                child: Column(
                  children: [
                    // 拖影效果
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(0.0, 0.95),
                          radius: 0.9,
                          colors: [
                            colorScheme.primary.withAlpha(102),
                            colorScheme.primary.withAlpha(76),
                            colorScheme.primary.withAlpha(38),
                            colorScheme.primary.withAlpha(13),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                        ),
                      ),
                    ),
                    // 扫描线
                    Container(
                      height: 2,
                      margin:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withAlpha(76),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            colorScheme.primary.withAlpha(0),
                            colorScheme.primary,
                            colorScheme.primary,
                            colorScheme.primary.withAlpha(0),
                          ],
                          stops: const [0.0, 0.45, 0.55, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // 提示文本
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 32,
            left: 32,
            right: 32,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: (isDark ? Colors.white : Colors.black).withAlpha(153),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '将二维码对准屏幕，即可自动扫描',
                      style: TextStyle(
                        color: isDark ? Colors.black : Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
