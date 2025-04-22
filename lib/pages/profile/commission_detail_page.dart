import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/statistic_card.dart';
import 'widgets/commission_record_cell.dart';
import '../../models/commission_record.dart';
import '../../services/user_service.dart';
import '../../services/commission_service.dart';
import 'commission_record_page.dart';
import 'withdraw_page.dart';

/// 提成明细页面
class CommissionDetailPage extends StatefulWidget {
  /// 创建提成明细页面
  const CommissionDetailPage({super.key});

  @override
  State<CommissionDetailPage> createState() => _CommissionDetailPageState();
}

class _CommissionDetailPageState extends State<CommissionDetailPage> {
  final _commissionService = CommissionService();
  List<CommissionRecord>? _records;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _loadUserInfo();
  }

  Future<void> _loadRecords() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final records = await _commissionService.getCommissionRecords();
      if (mounted) {
        setState(() {
          _records = records;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadUserInfo() async {
    final userService = context.read<UserService>();
    await userService.getUserInfo();
  }

  // 同时刷新用户信息和提成记录
  Future<void> _refreshAll() async {
    // 并行加载数据以提高效率
    await Future.wait([
      _loadUserInfo(),
      _loadRecords(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userService = context.watch<UserService>();
    final user = userService.userInfo?.userInfo;
    final commission = user?.commission ?? 0.0;
    final balance = user?.amount ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('提成明细'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 顶部统计卡片
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: StatisticCard(
                    value: commission.toStringAsFixed(2),
                    label: '总提成（元）',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatisticCard(
                    value: balance.toStringAsFixed(2),
                    label: '余额（元）',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WithdrawPage(
                            balance: balance,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // 提成记录列表
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshAll,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _records?.isEmpty ?? true
                      ? const Center(child: Text('暂无记录'))
                      : ListView.builder(
                          itemCount: _records!.length,
                          itemBuilder: (context, index) {
                            final record = _records![index];
                            return CommissionRecordCell(
                              type: record.level,
                              orderNo: record.orderNo,
                              dateTime: record.createTime ?? '',
                              amount: record.changeAmount,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommissionRecordPage(
                                      record: record,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
