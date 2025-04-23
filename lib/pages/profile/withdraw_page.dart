import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/withdraw_service.dart';
import '../../services/bank_card_service.dart';
import 'bank_card_page.dart';

/// 提现页面
class WithdrawPage extends StatefulWidget {
  /// 创建提现页面
  const WithdrawPage({
    super.key,
    required this.balance,
  });

  /// 账户余额
  final double balance;

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _amountController = TextEditingController();
  final _withdrawService = WithdrawService();
  final _bankCardService = BankCardService();
  String _bankName = '';
  String _cardNo = '';
  bool _isValid = false;
  bool _isLoading = false;
  bool _isLoadingBankCard = true;
  double _fee = 0; // 添加手续费变量
  String? _errorText; // 添加错误提示文本

  @override
  void initState() {
    super.initState();
    _loadBankCardInfo();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // 加载银行卡信息
  Future<void> _loadBankCardInfo() async {
    setState(() {
      _isLoadingBankCard = true;
    });

    try {
      final bankCard = await _bankCardService.getBankCard();
      if (mounted) {
        setState(() {
          if (bankCard != null) {
            _bankName = bankCard.bankName;
            _cardNo = bankCard.cardNo.substring(bankCard.cardNo.length - 4);
          } else {
            _bankName = '未绑定银行卡';
            _cardNo = '';
          }
          _isLoadingBankCard = false;
        });
      }
    } catch (e) {
      print('加载银行卡信息失败: $e');
      if (mounted) {
        setState(() {
          _bankName = '加载失败';
          _cardNo = '';
          _isLoadingBankCard = false;
        });
      }
    }
  }

  void _onAmountChanged(String value) {
    final amount = double.tryParse(value) ?? 0;
    setState(() {
      _isValid = amount > 0 && amount <= widget.balance;
      // 计算手续费（3%）
      _fee = amount * 0.03;
      // 设置错误提示
      _errorText = amount > widget.balance ? '输入金额超过零钱余额' : null;
    });
  }

  Future<void> _handleWithdraw() async {
    if (!_isValid || _isLoading) return;

    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入有效的提现金额'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _withdrawService.withdraw(amount);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          behavior: SnackBarBehavior.floating,
        ),
      );

      if (result.success) {
        Navigator.pop(context, true); // 返回true表示提现成功
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('网络异常，请稍后重试'),
            behavior: SnackBarBehavior.floating,
          ),
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('提现'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 到账方式
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.outlineVariant.withAlpha(50),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BankCardPage(),
                              ),
                            );
                            if (result == true) {
                              // 如果返回true，表示银行卡信息已更新，重新加载
                              _loadBankCardInfo();
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  '到账方式',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const Spacer(),
                                _isLoadingBankCard
                                    ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: colorScheme.primary,
                                        ),
                                      )
                                    : Text(
                                        _cardNo.isEmpty
                                            ? _bankName
                                            : '$_bankName 尾号$_cardNo',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  size: 20,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 提现金额
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.outlineVariant.withAlpha(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '提现金额',
                            style: TextStyle(
                              fontSize: 15,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '¥',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  controller: _amountController,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSurface,
                                    height: 1.1,
                                    letterSpacing: -0.5,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'),
                                    ),
                                  ],
                                  onChanged: _onAmountChanged,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '手续费（3%）',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '¥${_fee.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '零钱余额',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                '¥${widget.balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          if (_errorText != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              _errorText!,
                              style: TextStyle(
                                fontSize: 13,
                                color: colorScheme.error,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 确定按钮
            Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                0,
                16,
                16 + MediaQuery.of(context).padding.bottom,
              ),
              child: FilledButton(
                onPressed: _isValid &&
                        !_isLoading &&
                        !_isLoadingBankCard &&
                        _cardNo.isNotEmpty
                    ? _handleWithdraw
                    : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        '确定',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
