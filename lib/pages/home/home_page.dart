import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../pages/pages.dart';
import '../../pages/scanner/qr_scanner_page.dart';
import '../../theme/app_theme.dart';
import '../../services/fortune_service.dart';
import '../../models/fortune.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _fortuneService = FortuneService();
  FortuneResponse? _fortuneData;
  FortuneResponse? _userFortuneData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFortuneData();
  }

  // 获取状态栏和AppBar的总高度
  double get _topPadding =>
      MediaQuery.of(context).padding.top + AppBar().preferredSize.height;

  static const bgUrl = 'assets/images/navigation_bar_bg.jpg';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _loadFortuneData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final today = DateTime.now();
      final dateStr =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      final fortuneData = await _fortuneService.getFortune(dateStr);
      final userFortuneData = await _fortuneService.getUserFortune(dateStr);

      if (mounted) {
        setState(() {
          _fortuneData = fortuneData;
          _userFortuneData = userFortuneData;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('获取运势数据失败: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取运势数据失败')),
        );
      }
    }
  }

  Future<void> _onScanPressed() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScannerPage(),
      ),
    );

    if (!mounted) return;

    if (result != null) {}
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : IndexedStack(
                      index: _selectedIndex,
                      children: [
                        CalendarPage(fortuneData: _fortuneData?.data),
                        FortunePage(fortuneData: _userFortuneData?.data),
                        const ProfilePage(),
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
