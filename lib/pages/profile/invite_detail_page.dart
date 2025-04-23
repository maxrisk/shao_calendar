import 'package:flutter/material.dart';
import '../../services/invite_service.dart';
import '../../services/user_service.dart';
import '../../models/invite_record.dart';
import 'widgets/statistic_card.dart';
import 'widgets/invite_record_cell.dart';
import 'member_detail_page.dart';

/// 邀请明细页面
class InviteDetailPage extends StatefulWidget {
  /// 创建邀请明细页面
  const InviteDetailPage({super.key});

  @override
  State<InviteDetailPage> createState() => _InviteDetailPageState();
}

class _InviteDetailPageState extends State<InviteDetailPage> {
  final _inviteService = InviteService();
  final _userService = UserService();
  late Future<List<InviteRecord>> _recordsFuture;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // 初始化_recordsFuture，避免LateInitializationError
    _recordsFuture = _inviteService.getInviteRecords();
    // 然后加载数据，这会更新_recordsFuture
    _loadData();
  }

  // 加载所有数据
  Future<void> _loadData() async {
    // 获取最新的用户信息
    await _userService.getUserInfo();
    // 重新获取邀请记录
    setState(() {
      _recordsFuture = _inviteService.getInviteRecords();
    });
  }

  // 刷新数据
  Future<void> _refreshData() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    try {
      await _loadData();
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final userInfo = _userService.userInfo?.userInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('邀请明细'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: StatisticCard(
                      value: '${userInfo?.firstCount ?? 0}',
                      label: '直接邀请',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatisticCard(
                      value: '${userInfo?.secondCount ?? 0}',
                      label: '间接邀请',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<InviteRecord>>(
                future: _recordsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48,
                            color: colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '加载失败',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final records = snapshot.data!;
                  if (records.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_add_disabled_rounded,
                            size: 48,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '暂无邀请记录',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '邀请好友加入，获得奖励',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return InviteRecordCell(
                        phoneNumber: record.phone ?? '未知用户',
                        inviteTypeLabel: record.inviteTypeLabel,
                        paymentStatusLabel: record.paymentStatusLabel,
                        isPaid: record.isPaid,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemberDetailPage(
                                userId: record.userId,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
