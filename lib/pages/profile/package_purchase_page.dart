import 'package:flutter/material.dart';
import '../../models/package.dart';
import '../../models/package_group.dart';
import 'payment_page.dart';

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
  String? _errorMessage;

  String get _title => widget.package != null ? '单项服务' : '服务包';
  String get _name => widget.package?.name ?? widget.packageGroup!.name;
  double get _price => widget.package?.price ?? widget.packageGroup!.price;
  String? get _imageUrl =>
      widget.package?.coverImage ?? widget.packageGroup?.coverImage;
  String? get _description =>
      widget.package?.description ?? widget.packageGroup?.description;

  void _handlePurchase() {
    if (!mounted) return;

    if (widget.package != null) {
      // 跳转到单项服务支付页面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            amount: _price,
            title: _name,
            serviceType: ServiceType.package,
            packageId: widget.package!.id,
          ),
        ),
      );
    } else if (widget.packageGroup != null) {
      // 跳转到服务包支付页面
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            amount: _price,
            title: _name,
            serviceType: ServiceType.packageGroup,
            packageGroupId: widget.packageGroup!.id,
          ),
        ),
      );
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
      body: SingleChildScrollView(
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
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return FadeTransition(
                            opacity: AlwaysStoppedAnimation(1.0),
                            child: child,
                          );
                        }
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: colorScheme.surfaceVariant,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                              color: colorScheme.primary,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image_rounded,
                                size: 40,
                                color: colorScheme.onErrorContainer,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '图片加载失败',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.onErrorContainer,
                                ),
                              ),
                            ],
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
                        color: colorScheme.primaryContainer.withOpacity(0.85),
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
                      _description ?? '暂无服务说明',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 错误信息
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: _handlePurchase,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
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
}
