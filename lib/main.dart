import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'theme/app_theme.dart';
import 'services/user_service.dart';
import 'package:provider/provider.dart';
import 'services/http_client.dart';
import 'pages/home/home_page.dart';
import 'pages/profile/complete_info_page.dart';
import 'services/fortune_service.dart';
import 'utils/shared_prefs.dart';
import 'widgets/dialogs/agreement_dialog.dart';
import 'pages/profile/payment_result_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置 URL 策略为路径模式
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }

  // 初始化共享偏好设置
  await SharedPrefs.init();

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
          ChangeNotifierProvider(create: (_) => userService),
          Provider(create: (_) => FortuneService()),
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
    // 延迟检查用户协议，确保界面已构建完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserAgreement();
    });
  }

  // 检查用户是否同意用户协议和隐私政策
  Future<void> _checkUserAgreement() async {
    // 如果用户未同意协议，则显示协议弹窗
    if (!SharedPrefs.isUserAgreementAccepted() && mounted) {
      final navigatorContext =
          HttpClient.navigatorKey.currentContext ?? context;
      final result = await AgreementDialog.show(navigatorContext);

      if (result == true && mounted) {
        // 用户同意协议
        await SharedPrefs.setUserAgreementAccepted(true);
        // 用户数据初始化放在这里
        _initUserData();
      }
      // 用户不同意协议的情况由AgreementDialog内部处理（调用_exitApp方法）
    } else {
      // 用户已经同意过协议，继续初始化用户数据
      _initUserData();
    }
  }

  Future<void> _initUserData() async {
    if (!mounted) return;

    final userService = context.read<UserService>();
    // 检查是否有token
    final token = userService.getToken();
    if (token != null) {
      // 有token就尝试获取用户信息
      final userInfo = await userService.getUserInfo();
      if (userInfo != null) {
        // 检查是否需要补充信息
        if (mounted &&
            (userInfo.userInfo.birthDate == null ||
                userInfo.userInfo.birthTime == null)) {
          final navigatorContext =
              HttpClient.navigatorKey.currentContext ?? context;
          Navigator.push(
            navigatorContext,
            MaterialPageRoute(
              builder: (context) => const CompleteInfoPage(),
            ),
          );
        }
      } else {
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
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/payment-result') == true) {
          // 解析 URL 中的查询参数
          final uri = Uri.parse(settings.name!);
          final params = Map<String, String>.from(uri.queryParameters);
          print('支付回调参数: $params');

          return MaterialPageRoute(
            builder: (context) {
              if (params.isEmpty) {
                return const Scaffold(
                  body: Center(
                    child: Text('无效的支付结果参数'),
                  ),
                );
              }
              return PaymentResultPage(params: params);
            },
          );
        }
        // 处理其他路由...
        return null;
      },
    );
  }
}
