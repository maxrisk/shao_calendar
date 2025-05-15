import 'package:flutter/material.dart';
import '../../models/divination.dart';
import '../../services/fortune_service.dart';
import '../../models/fortune.dart';
import 'dart:async';

class PersonalDivinationPage extends StatefulWidget {
  final Divination divination;
  final String yearRange;

  const PersonalDivinationPage({
    super.key,
    required this.divination,
    required this.yearRange,
  });

  @override
  State<PersonalDivinationPage> createState() => _PersonalDivinationPageState();
}

class _PersonalDivinationPageState extends State<PersonalDivinationPage> {
  int _currentYear = DateTime.now().year;
  final _fortuneService = FortuneService();
  bool _isLoading = false;
  FortuneResponse? _fortuneData;
  Timer? _debounceTimer;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _loadFortuneData();
  }

  @override
  void dispose() {
    _isMounted = false;
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadFortuneData() async {
    // 取消之前的定时器
    _debounceTimer?.cancel();

    // 如果正在加载，延迟500毫秒后重试
    if (_isLoading) {
      _debounceTimer =
          Timer(const Duration(milliseconds: 500), _loadFortuneData);
      return;
    }

    if (!_isMounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final now = DateTime.now();
      final dateStr =
          '$_currentYear-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

      final response = await _fortuneService.getUserFortune(dateStr);

      if (!_isMounted) return;

      setState(() {
        _fortuneData = response;
        _isLoading = false;
      });
    } catch (e) {
      if (!_isMounted) return;

      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('获取${_currentYear}年运势数据失败'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _previousYear() {
    if (_isLoading) return;
    setState(() {
      _currentYear--;
    });
    _loadFortuneData();
  }

  void _nextYear() {
    if (_isLoading) return;
    setState(() {
      _currentYear++;
    });
    _loadFortuneData();
  }

  @override
  Widget build(BuildContext context) {
    final divination = _fortuneData?.data?.thisYear ?? widget.divination;
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('个人年卦'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // 年份选择器
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _previousYear,
                        icon: const Icon(Icons.chevron_left),
                        iconSize: 32,
                      ),
                      const SizedBox(width: 24),
                      Column(
                        children: [
                          Text(
                            '$_currentYear',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '${divination.name}年',
                            style: TextStyle(
                              fontSize: 16,
                              color: colorScheme.primary.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        onPressed: _nextYear,
                        icon: const Icon(Icons.chevron_right),
                        iconSize: 32,
                      ),
                    ],
                  ),
                ),
                // 指引卡片
                if (divination.guide != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: theme.cardColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          divination.guide!,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    height: 1.6,
                                  ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
