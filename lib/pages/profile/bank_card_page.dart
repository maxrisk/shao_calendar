import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    String? hintText,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outlineVariant.withAlpha(50),
            ),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 15,
              height: 1.2,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: colorScheme.onSurfaceVariant,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: InputBorder.none,
              counterText: '',
            ),
            maxLength: maxLength,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onChanged: (_) => _checkValid(),
          ),
        ),
      ],
    );
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
                    _buildTextField(
                      label: '姓名',
                      controller: _nameController,
                      hintText: '请输入姓名',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: '身份证号',
                      controller: _idCardController,
                      hintText: '请输入身份证号',
                      maxLength: 18,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9Xx]')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '开户银行',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
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
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Theme.of(context).cardColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                  ),
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: colorScheme.outlineVariant
                                                  .withAlpha(50),
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              '选择开户银行',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: colorScheme.onSurface,
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              icon: Icon(
                                                Icons.close_rounded,
                                                size: 20,
                                                color: colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                              style: IconButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: _banks.length,
                                          itemBuilder: (context, index) {
                                            final bank = _banks[index];
                                            return Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedBank = bank;
                                                  });
                                                  _checkValid();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16,
                                                    vertical: 14,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: colorScheme
                                                            .outlineVariant
                                                            .withAlpha(50),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    bank,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          colorScheme.onSurface,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      _selectedBank ?? '请选择开户银行',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: _selectedBank != null
                                            ? colorScheme.onSurface
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const Spacer(),
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: '银行卡号',
                      controller: _cardNoController,
                      hintText: '请输入银行卡号',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
