import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'widgets/bottom_nav_bar.dart';
import 'pages/pages.dart';
import 'pages/scanner/qr_scanner_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '邵氏先天历',
      theme: AppTheme.themeData,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],
      locale: const Locale('zh', 'CN'),
      home: const MyHomePage(title: '邵氏先天历'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    // 获取屏幕尺寸
    final size = MediaQuery.of(context).size;
    // 计算图片展示高度，保持原图比例
    final imageHeight = size.width * 580 / 750; // 假设原图是 16:9 的比例

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
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
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: _onScanPressed,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: -_topPadding,
            left: 0,
            right: 0,
            height: imageHeight,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.primaryColor,
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgUrl),
                    fit: BoxFit.fitWidth, // 修改为 fitWidth 确保横向填充
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
          )),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
