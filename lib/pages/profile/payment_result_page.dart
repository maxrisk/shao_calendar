import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import '../../services/payment_service.dart';

/// 支付结果页面
class PaymentResultPage extends StatefulWidget {
  /// 创建支付结果页面
  const PaymentResultPage({
    super.key,
    required this.params,
  });

  /// 支付结果参数
  final Map<String, String> params;

  @override
  State<PaymentResultPage> createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends State<PaymentResultPage> {
  bool _isLoading = true;
  bool _isSuccess = false;
  String _message = '';
  final _paymentService = PaymentService();

  @override
  void initState() {
    super.initState();
    _checkPaymentResult();
  }

  Future<void> _checkPaymentResult() async {
    try {
      // 验证支付结果
      final verifyResult = await _paymentService.verifyPayment(
        params: widget.params,
      );

      if (!verifyResult) {
        setState(() {
          _isLoading = false;
          _isSuccess = false;
          _message = '支付验证失败';
        });
        return;
      }

      // 支付成功后更新用户信息
      final userService = context.read<UserService>();
      final userInfo = await userService.getUserInfo();

      setState(() {
        _isLoading = false;
        _isSuccess = userInfo != null;
        _message = userInfo != null ? '支付成功' : '支付成功，但更新用户信息失败';
      });

      if (mounted && _isSuccess) {
        // 延迟2秒后返回
        // Future.delayed(const Duration(seconds: 3), () {
        //   if (mounted) {
        //     Navigator.pop(context); // 返回到服务页面
        //   }
        // });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isSuccess = false;
        _message = '验证支付结果失败';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('支付结果'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isSuccess ? Icons.check_circle : Icons.error,
                    size: 64,
                    color: _isSuccess ? colorScheme.primary : colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _message,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          _isSuccess ? colorScheme.primary : colorScheme.error,
                    ),
                  ),
                  if (!_isSuccess) ...[
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('返回'),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
