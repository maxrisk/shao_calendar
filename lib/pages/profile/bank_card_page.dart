import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/dialogs/index.dart' as custom;
import '../../widgets/form/form_field.dart';
import '../../widgets/dialogs/bottom_sheet_item.dart';

/// 银行卡信息
class BankCard {
  /// 创建银行卡信息
  const BankCard({
    required this.name,
    required this.idCard,
    required this.bankName,
    required this.cardNo,
  });

  /// 姓名
  final String name;

  /// 身份证号
  final String idCard;

  /// 开户银行
  final String bankName;

  /// 银行卡号
  final String cardNo;
}

/// 银行卡信息页面
class BankCardPage extends StatefulWidget {
  /// 创建银行卡信息页面
  const BankCardPage({super.key});

  @override
  State<BankCardPage> createState() => _BankCardPageState();
}

class _BankCardPageState extends State<BankCardPage> {
  final _nameController = TextEditingController();
  final _idCardController = TextEditingController();
  final _cardNoController = TextEditingController();
  String? _selectedBank;
  bool _isValid = false;

  // 模拟银行列表数据
  final _banks = const [
    '工商银行',
    '建设银行',
    '农业银行',
    '中国银行',
    '交通银行',
    '招商银行',
    '邮储银行',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _idCardController.dispose();
    _cardNoController.dispose();
    super.dispose();
  }

  void _checkValid() {
    setState(() {
      _isValid = _nameController.text.isNotEmpty &&
          _idCardController.text.length == 18 &&
          _selectedBank != null &&
          _cardNoController.text.length >= 16;
    });
  }

  void _handleSubmit() {
    if (_isValid) {
      Navigator.pop(
        context,
        BankCard(
          name: _nameController.text,
          idCard: _idCardController.text,
          bankName: _selectedBank!,
          cardNo: _cardNoController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('银行卡信息'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormItem(
                      label: '姓名',
                      hint: '请输入姓名',
                      icon: Icons.person_outline_rounded,
                      controller: _nameController,
                      onChanged: (_) => _checkValid(),
                    ),
                    const SizedBox(height: 16),
                    FormItem(
                      label: '身份证号',
                      hint: '请输入身份证号',
                      icon: Icons.credit_card_outlined,
                      controller: _idCardController,
                      maxLength: 18,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9Xx]')),
                      ],
                      onChanged: (_) => _checkValid(),
                    ),
                    const SizedBox(height: 16),
                    FormItem(
                      label: '开户银行',
                      hint: '请选择开户银行',
                      icon: Icons.account_balance_outlined,
                      type: FormFieldType.select,
                      value: _selectedBank,
                      onTap: () {
                        custom.BottomSheet.show(
                          context: context,
                          title: '选择开户银行',
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.5,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _banks.length,
                            itemBuilder: (context, index) {
                              final bank = _banks[index];
                              return BottomSheetItem(
                                title: bank,
                                onTap: () {
                                  setState(() {
                                    _selectedBank = bank;
                                  });
                                  _checkValid();
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FormItem(
                      label: '银行卡号',
                      hint: '请输入银行卡号',
                      icon: Icons.credit_card_outlined,
                      controller: _cardNoController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (_) => _checkValid(),
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
                onPressed: _isValid ? _handleSubmit : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
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
