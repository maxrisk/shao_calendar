import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/list/list_cell.dart';
import '../../widgets/list/list_group.dart';

/// 付款页面
class PaymentPage extends StatefulWidget {
  /// 创建付款页面
  const PaymentPage({
    super.key,
    required this.amount,
    required this.title,
  });

  /// 金额
  final double amount;

  /// 标题
  final String title;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'alipay'; // 默认选择支付宝

  void _handleConfirmPayment() {
    // TODO: 处理付款逻辑
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('付款'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 价格显示
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '¥',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.amount.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 付款方式
                  ListGroup(
                    title: '付款方式',
                    children: [
                      ListCell(
                        icon: FontAwesomeIcons.alipay,
                        iconColor: const Color(0xFF1677FF),
                        title: '支付宝支付',
                        showArrow: false,
                        trailing: Radio<String>(
                          value: 'alipay',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value!;
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = 'alipay';
                          });
                        },
                      ),
                      ListCell(
                        icon: FontAwesomeIcons.weixin,
                        iconColor: const Color(0xFF07C160),
                        title: '微信支付',
                        showArrow: false,
                        trailing: Radio<String>(
                          value: 'wechat',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value!;
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = 'wechat';
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 确认付款按钮
          Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              16 + MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _handleConfirmPayment,
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '确认付款',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
