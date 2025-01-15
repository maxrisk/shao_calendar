import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../pages/pages.dart';
import '../../pages/scanner/qr_scanner_page.dart';
import '../../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 获取状态栏和AppBar的总高度
  double get _topPadding =>
      MediaQuery.of(context).padding.top + AppBar().preferredSize.height;

  static const bgUrl = 'assets/images/navigation_bar_bg.jpg';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _onScanPressed() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScannerPage(),
      ),
    );

    if (!mounted) return; // 确保在使用 context 前检查 mounted

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('扫描结果: $result')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.width * 580 / 750;
    final bool showAppBar = _selectedIndex != 2;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 根据当前页面设置状态栏样式
    final statusBarStyle = showAppBar
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
            statusBarIconBrightness:
                isDark ? Brightness.light : Brightness.dark,
          );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: statusBarStyle,
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                elevation: 0,
                title: Text(widget.title),
                titleTextStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bgUrl),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner_rounded),
                    onPressed: _onScanPressed,
                    color: Colors.white,
                  ),
                ],
              )
            : null,
        body: Stack(
          children: [
            if (showAppBar)
              Positioned(
                top: -_topPadding,
                left: 0,
                right: 0,
                height: imageHeight,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.primaryColor,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.7, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(bgUrl),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            SafeArea(
              child: IndexedStack(
                index: _selectedIndex,
                children: const [
                  CalendarPage(),
                  FortunePage(),
                  ProfilePage(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
