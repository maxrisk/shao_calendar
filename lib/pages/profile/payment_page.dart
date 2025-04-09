import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../widgets/list/list_cell.dart';
import '../../widgets/list/list_group.dart';
import '../../models/order.dart';
import '../../services/alipay_service.dart';
import '../../services/user_service.dart';
import '../../services/package_service.dart';
import '../../services/order_service.dart' as order_service
    show OrderService, ProductType, PayType;

/// 服务类型
enum ServiceType {
  /// 天历服务
  calendar,

  /// 单项服务
  package,

  /// 服务包
  packageGroup,
}

/// 付款页面
class PaymentPage extends StatefulWidget {
  /// 创建付款页面
  const PaymentPage({
    super.key,
    required this.amount,
    required this.title,
    required this.serviceType,
    this.productType = order_service.ProductType.normal,
    this.packageId,
    this.packageGroupId,
  }) : assert(
          (serviceType == ServiceType.calendar) ||
              (serviceType == ServiceType.package && packageId != null) ||
              (serviceType == ServiceType.packageGroup &&
                  packageGroupId != null),
          '单项服务需提供packageId，服务包需提供packageGroupId',
        );

  /// 金额
  final double amount;

  /// 标题
  final String title;

  /// 服务类型
  final ServiceType serviceType;

  /// 产品类型（只用于天历服务）
  final order_service.ProductType productType;

  /// 单项服务ID
  final int? packageId;

  /// 服务包ID
  final int? packageGroupId;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'alipay'; // 默认选择支付宝
  bool _isLoading = false;

  final _orderService = order_service.OrderService();
  final _packageService = PackageService();
  final _alipayService = AlipayService();

  Future<void> _handleConfirmPayment() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // 使用package_service.dart中的PayType
      final payType =
          _selectedPaymentMethod == 'alipay' ? PayType.alipay : PayType.wechat;

      // 根据不同服务类型创建订单
      final response = await _createOrder(payType);

      if (response?.code == 0 && response?.payUrl != null) {
        if (_selectedPaymentMethod == 'alipay') {
          // 调用支付宝支付
          final success = await _alipayService.pay(response!.payUrl!);
          if (success) {
            if (mounted) {
              // 支付成功后更新用户信息
              final userService = context.read<UserService>();
              final userInfo = await userService.getUserInfo();

              if (userInfo != null) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('支付成功')),
                  );
                  Navigator.pop(context);
                  Navigator.pop(context); // 返回到服务页面
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('支付成功，但更新用户信息失败')),
                  );
                }
              }
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('支付失败')),
              );
            }
          }
        } else {
          // TODO: 处理微信支付
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('暂不支持微信支付')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('创建订单失败')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('支付异常: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 根据服务类型创建对应的订单
  Future<OrderResponse?> _createOrder(PayType payType) async {
    switch (widget.serviceType) {
      case ServiceType.calendar:
        // 将PayType转换为order_service.PayType
        order_service.PayType orderPayType;
        if (payType == PayType.alipay) {
          orderPayType = order_service.PayType.alipay;
        } else {
          orderPayType = order_service.PayType.wechat;
        }
        return await _orderService.createOrder(
            orderPayType, widget.productType);
      case ServiceType.package:
        return await _packageService.createPackageOrder(
            widget.packageId!, payType);
      case ServiceType.packageGroup:
        return await _packageService.createPackageGroupOrder(
            widget.packageGroupId!, payType);
    }
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
      body: Stack(
        children: [
          Column(
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
                    onPressed: _isLoading ? null : _handleConfirmPayment,
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _isLoading ? '处理中...' : '确认付款',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
