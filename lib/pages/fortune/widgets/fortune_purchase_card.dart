import 'package:flutter/material.dart';

/// 运势购买卡片组件
class FortunePurchaseCard extends StatelessWidget {
  /// 创建运势购买卡片组件
  const FortunePurchaseCard({
    super.key,
    this.onPurchase,
  });

  /// 购买回调
  final VoidCallback? onPurchase;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '全年运势解锁仅需 ',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                '¥365',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onPurchase,
            style: TextButton.styleFrom(
              minimumSize: const Size(120, 36),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: const Text(
              '立即购买',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
