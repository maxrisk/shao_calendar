import 'package:flutter/material.dart';
import '../../services/package_service.dart';
import '../../models/package_order.dart';
import '../../models/single_package_order.dart';

/// 订单类型枚举
enum OrderType {
  /// 服务包订单
  packageGroup,

  /// 单项服务订单
  singlePackage,
}

/// 服务购买记录页面
class PackageOrderHistoryPage extends StatefulWidget {
  /// 创建服务购买记录页面
  const PackageOrderHistoryPage({super.key});

  @override
  State<PackageOrderHistoryPage> createState() =>
      _PackageOrderHistoryPageState();
}

class _PackageOrderHistoryPageState extends State<PackageOrderHistoryPage> {
  List<PackageOrderItem>? _packageGroupOrders;
  List<SinglePackageOrderItem>? _singlePackageOrders;
  bool _isLoading = false;
  final _packageService = PackageService();
  OrderType _currentOrderType = OrderType.packageGroup;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 加载所选类型的订单
      if (_currentOrderType == OrderType.packageGroup) {
        final orders = await _packageService.getPackageGroupOrders();
        if (mounted) {
          setState(() {
            _packageGroupOrders = orders;
            _isLoading = false;
          });
        }
      } else {
        final orders = await _packageService.getSinglePackageOrders();
        if (mounted) {
          setState(() {
            _singlePackageOrders = orders;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('获取订单列表失败')),
        );
      }
    }
  }

  void _switchOrderType(OrderType type) {
    if (type != _currentOrderType) {
      setState(() {
        _currentOrderType = type;
      });
      _loadOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('购买记录'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 切换按钮
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<OrderType>(
              segments: const [
                ButtonSegment<OrderType>(
                  value: OrderType.packageGroup,
                  label: Text('服务包'),
                  icon: Icon(Icons.layers),
                ),
                ButtonSegment<OrderType>(
                  value: OrderType.singlePackage,
                  label: Text('单项服务'),
                  icon: Icon(Icons.assignment),
                ),
              ],
              selected: {_currentOrderType},
              onSelectionChanged: (Set<OrderType> selected) {
                _switchOrderType(selected.first);
              },
              showSelectedIcon: false,
            ),
          ),
          // 订单列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildOrderList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    final colorScheme = Theme.of(context).colorScheme;

    // 根据当前选中的订单类型，显示对应的订单列表
    if (_currentOrderType == OrderType.packageGroup) {
      if (_packageGroupOrders == null || _packageGroupOrders!.isEmpty) {
        return Center(
          child: Text(
            '暂无服务包购买记录',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _packageGroupOrders!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = _packageGroupOrders![index];
          return _buildPackageGroupOrderCard(context, order);
        },
      );
    } else {
      if (_singlePackageOrders == null || _singlePackageOrders!.isEmpty) {
        return Center(
          child: Text(
            '暂无单项服务购买记录',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _singlePackageOrders!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = _singlePackageOrders![index];
          return _buildSinglePackageOrderCard(context, order);
        },
      );
    }
  }

  Widget _buildPackageGroupOrderCard(
      BuildContext context, PackageOrderItem order) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左侧内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_outlined,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          order.orderNo,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                            fontFamily: 'monospace',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order.formattedCreateTime,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 右侧内容
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '¥${order.total}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: order.status == 'PAYED'
                        ? colorScheme.primary.withAlpha(25)
                        : colorScheme.error.withAlpha(25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order.status == 'PAYED' ? '已支付' : '未支付',
                    style: TextStyle(
                      fontSize: 12,
                      color: order.status == 'PAYED'
                          ? colorScheme.primary
                          : colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSinglePackageOrderCard(
      BuildContext context, SinglePackageOrderItem order) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左侧内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_outlined,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          order.orderNo,
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                            fontFamily: 'monospace',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        order.formattedCreateTime,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 右侧内容
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '¥${order.total}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: order.status == 'PAYED'
                        ? colorScheme.primary.withAlpha(25)
                        : colorScheme.error.withAlpha(25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order.status == 'PAYED' ? '已支付' : '未支付',
                    style: TextStyle(
                      fontSize: 12,
                      color: order.status == 'PAYED'
                          ? colorScheme.primary
                          : colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
