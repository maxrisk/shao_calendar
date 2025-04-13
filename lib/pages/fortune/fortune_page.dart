import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import '../profile/widgets/login_prompt.dart';
import '../../widgets/fortune_card_group.dart';
import 'widgets/date_picker_button.dart';
import 'widgets/decorated_title.dart';
import 'widgets/fortune_display.dart';
import 'widgets/fortune_interpretation.dart';
import 'widgets/fortune_purchase_card.dart';
import '../../pages/profile/calendar_service_page.dart';
import '../../models/fortune.dart';
import '../../services/fortune_service.dart';
import '../../pages/profile/login_page.dart';
import '../../utils/route_animations.dart';

/// 个人运势页面
class FortunePage extends StatefulWidget {
  /// 创建个人运势页面
  const FortunePage({super.key, this.fortuneData});

  /// 个人运势数据
  final FortuneData? fortuneData;

  @override
  State<FortunePage> createState() => _FortunePageState();
}

class _FortunePageState extends State<FortunePage> {
  DateTime _selectedDate = DateTime.now();
  final _fortuneService = FortuneService();
  FortuneResponse? _fortuneData;
  bool _isLoading = false;
  bool? _previousLoginState;

  @override
  void initState() {
    super.initState();
    _fortuneData = widget.fortuneData != null
        ? FortuneResponse(code: 0, data: widget.fortuneData)
        : null;
    if (_fortuneData == null) {
      _loadFortuneData(_selectedDate);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 监听用户登录状态变化
    final userService = context.watch<UserService>();
    final isLoggedIn = userService.userInfo != null;

    // 如果用户从未登录状态变为已登录状态，刷新数据
    if (_previousLoginState == false && isLoggedIn) {
      _loadFortuneData(_selectedDate);
    }
    _previousLoginState = isLoggedIn;
  }

  Future<void> _loadFortuneData(DateTime date) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final response = await _fortuneService.getUserFortune(dateStr);
      if (mounted) {
        setState(() {
          _fortuneData = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取个人运势数据失败')),
        );
      }
    }
  }

  void _previousDay() {
    final previousDate = _selectedDate.subtract(const Duration(days: 1));
    setState(() {
      _selectedDate = previousDate;
    });
    _loadFortuneData(previousDate);
  }

  void _nextDay() {
    final nextDate = _selectedDate.add(const Duration(days: 1));
    setState(() {
      _selectedDate = nextDate;
    });
    _loadFortuneData(nextDate);
  }

  @override
  Widget build(BuildContext context) {
    final userService = context.watch<UserService>();
    final isLoggedIn = userService.userInfo != null;

    if (!isLoggedIn) {
      return LoginPrompt(
        onLogin: () {
          Navigator.push(
            context,
            RouteAnimations.slideUp(
              page: const LoginPage(),
            ),
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              children: [
                // 顶部卡片区域
                FortuneCardGroup(
                  fortuneData: _fortuneData?.data,
                  onCardTap: (cardType) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('查看${cardType == 'base' ? '本命卦' : '大运卦'}详情'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                // 革年标题
                const DecoratedTitle(title: '革年'),
                // 日期选择按钮
                DatePickerButton(
                  date: _selectedDate,
                  onDateChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                    _loadFortuneData(date);
                  },
                ),
                // 运势展示卡片
                FortuneDisplay(
                  date: _selectedDate,
                  onPrevious: _previousDay,
                  onNext: _nextDay,
                  divination: _fortuneData?.data?.dayDivinationInfo,
                  isLoading: _isLoading,
                ),
                // 购买卡片
                if (!userService.isVip)
                  FortunePurchaseCard(
                    onPurchase: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CalendarServicePage(),
                        ),
                      );
                    },
                  ),
                // 运势解读
                FortuneInterpretation(
                  yaos: _fortuneData?.data?.yaos,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
