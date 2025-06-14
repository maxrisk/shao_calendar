import 'package:flutter/material.dart';
import '../../services/package_service.dart';
import '../../models/package.dart';
import '../../models/package_group.dart';
import 'package_purchase_page.dart';
import 'package_order_history_page.dart';

/// 定制服务页面
class CustomServicePage extends StatefulWidget {
  /// 创建定制服务页面
  const CustomServicePage({super.key});

  @override
  State<CustomServicePage> createState() => _CustomServicePageState();
}

class _CustomServicePageState extends State<CustomServicePage> {
  final _packageService = PackageService();

  List<Package> _packages = [];
  List<PackageGroup> _packageGroups = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final packagesResult = await _packageService.getPackages();
      final packageGroupsResult = await _packageService.getPackageGroups();

      setState(() {
        _packages = packagesResult;
        _packageGroups = packageGroupsResult;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '加载服务数据失败，请稍后重试';
      });
    }
  }

  void _navigateToOrderHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PackageOrderHistoryPage(),
      ),
    );
  }

  void _navigateToPackagePurchase(Package package) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackagePurchasePage(package: package),
      ),
    );
  }

  void _navigateToPackageGroupPurchase(PackageGroup packageGroup) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackagePurchasePage(packageGroup: packageGroup),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('定制服务'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: _navigateToOrderHistory,
            child: Text(
              '购买记录',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMessage!, style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 服务包卡片
                      if (_packageGroups.isNotEmpty)
                        ..._packageGroups.map(
                            (group) => _buildPackageGroupCard(context, group)),

                      const SizedBox(height: 32),

                      // 单项服务标题
                      if (_packages.isNotEmpty)
                        Center(
                          child: Text(
                            '单项定制服务',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      // 单项服务列表
                      ..._packages.map((package) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildServiceItem(
                              context,
                              package.name,
                              '${package.price}元',
                              package.id,
                              onTap: () => _navigateToPackagePurchase(package),
                            ),
                          )),
                    ],
                  ),
                ),
    );
  }

  Widget _buildPackageGroupCard(BuildContext context, PackageGroup group) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _navigateToPackageGroupPurchase(group),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 左侧内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      group.description ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              // 右侧价格
              Text(
                '${group.price}元',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(
      BuildContext context, String title, String price, int id,
      {VoidCallback? onTap}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap ??
            () {
              // 创建一个临时的单项服务对象
              final defaultPackage = Package(
                id: id,
                name: title,
                description: '$title的详细描述',
                price: double.tryParse(price.replaceAll('元', '')) ?? 0,
                originalPrice: 0,
                validDays: 365,
                status: 1,
              );
              _navigateToPackagePurchase(defaultPackage);
            },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                price,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
