import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/app_theme.dart';
import 'services/user_service.dart';
import 'package:provider/provider.dart';
import 'services/http_client.dart';
import 'pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化HTTP客户端
  final httpClient = HttpClient();
  await httpClient.init();

  // 初始化用户服务
  final userService = UserService();
  await userService.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: userService),
        ],
        child: const App(),
      ),
    );
  });
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initUserData();
  }

  Future<void> _initUserData() async {
    final userService = context.read<UserService>();
    // 检查是否有token
    final token = userService.getToken();
    if (token != null) {
      // 有token就尝试获取用户信息
      final userInfo = await userService.getUserInfo();
      if (userInfo == null) {
        // 获取失败，可能是token过期，清除token
        await userService.logout();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '邵氏先天历',
      navigatorKey: HttpClient.navigatorKey,
      theme: AppTheme.themeData.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: AppTheme.darkThemeData.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
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
      home: const HomePage(title: '邵氏先天历'),
    );
  }
}
