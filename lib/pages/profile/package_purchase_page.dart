import 'package:flutter/material.dart';
import '../../models/package.dart';
import '../../models/package_group.dart';
import '../../services/package_service.dart';

/// 服务包购买页面
class PackagePurchasePage extends StatefulWidget {
  /// 创建服务包购买页面
  ///
  /// [package] 和 [packageGroup] 两者只能传一个
  const PackagePurchasePage({
    super.key,
    this.package,
    this.packageGroup,
  })  : assert(package != null || packageGroup != null),
        assert(!(package != null && packageGroup != null));

  /// 单项服务
  final Package? package;

  /// 服务包
  final PackageGroup? packageGroup;

  @override
  State<PackagePurchasePage> createState() => _PackagePurchasePageState();
}

class _PackagePurchasePageState extends State<PackagePurchasePage> {
  PayType _selectedPayType = PayType.alipay;
  bool _isLoading = false;
  String? _errorMessage;

  String get _title => widget.package != null ? '单项服务' : '服务包';
  String get _name => widget.package?.name ?? widget.packageGroup!.name;
  double get _price => widget.package?.price ?? widget.packageGroup!.price;
  String? get _imageUrl =>
      widget.package?.coverImage ?? widget.packageGroup?.coverImage;
  String get _description =>
      widget.package?.description ?? widget.packageGroup!.description;

  /// 购买说明，如果API没返回则提供默认内容
  List<String> get _benefitsList {
    final List<String>? benefits =
        widget.package?.benefits ?? widget.packageGroup?.benefits;

    if (benefits != null && benefits.isNotEmpty) {
      return benefits;
    } else {
      return ['专业老师一对一服务', '购买后可在个人中心-购买记录中查看', '客服时间：9:00-18:00'];
    }
  }

  Future<void> _handlePurchase() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final packageService = PackageService();
      final response = widget.package != null
          ? await packageService.createPackageOrder(
              widget.package!.id, _selectedPayType)
          : await packageService.createPackageGroupOrder(
              widget.packageGroup!.id, _selectedPayType);

      setState(() {
        _isLoading = false;
      });

      if (response == null || response.payUrl == null) {
        setState(() {
          _errorMessage = '创建订单失败，请稍后重试';
        });
        return;
      }

      // TODO: 打开支付链接或跳转到支付页面
      print('支付URL: ${response.payUrl}');

      if (!mounted) return;

      // 显示成功提示
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('订单创建成功，请完成支付')),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '创建订单失败: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 价格
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '¥${_price.toStringAsFixed(2)}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 服务包名称
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 服务包图片
                  if (_imageUrl != null)
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            _imageUrl!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: colorScheme.primaryContainer,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // 右上角标签
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer
                                  .withOpacity(0.85),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.menu_book_outlined,
                                  size: 16,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '服务介绍',
                                  style: TextStyle(
                                    color: colorScheme.onPrimaryContainer,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),

                  // 服务详情卡片
                  Card(
                    color: theme.cardColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '服务说明',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _description,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 支付方式卡片
                  Card(
                    color: theme.cardColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '支付方式',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildPaymentOption(
                            PayType.alipay,
                            '支付宝支付',
                            Icons.account_balance_wallet,
                          ),
                          const SizedBox(height: 10),
                          _buildPaymentOption(
                            PayType.wechat,
                            '微信支付',
                            Icons.chat_bubble,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 错误信息
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handlePurchase,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      '立即购买',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(PayType payType, String title, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedPayType == payType;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPayType = payType;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? colorScheme.primary : Colors.grey.shade700,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: isSelected ? colorScheme.primary : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
