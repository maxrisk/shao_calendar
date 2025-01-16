import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/user_service.dart';
import '../../widgets/dialogs/index.dart' as custom;
import '../../widgets/form/form_field.dart';
import '../../widgets/dialogs/bottom_sheet_item.dart';

/// 补充信息页面
class CompleteInfoPage extends StatefulWidget {
  /// 创建补充信息页面
  const CompleteInfoPage({super.key});

  @override
  State<CompleteInfoPage> createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage> {
  final _referralController = TextEditingController();
  DateTime? _birthDate;
  int? _birthTimeIndex;

  // 时辰列表
  final _timeList = const [
    '0-4点',
    '4-8点',
    '8-12点',
    '12-16点',
    '16-20点',
    '20-24点',
  ];

  String? get _birthTime =>
      _birthTimeIndex != null ? _timeList[_birthTimeIndex!] : null;

  bool get _isValid => _birthDate != null && _birthTimeIndex != null;

  @override
  void dispose() {
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (date != null) {
      setState(() {
        _birthDate = date;
      });
    }
  }

  void _selectTime(BuildContext context) {
    custom.BottomSheet.show(
      context: context,
      title: '选择出生时辰',
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _timeList.length,
        itemBuilder: (context, index) {
          final time = _timeList[index];
          return BottomSheetItem(
            title: time,
            onTap: () {
              setState(() {
                _birthTimeIndex = index;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final userService = context.read<UserService>();
    final success = await userService.openFortune(
      '${_birthDate!.year}-${_birthDate!.month}-${_birthDate!.day}',
      _birthTimeIndex! + 1,
      code: _referralController.text,
    );
    if (success) {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('开启流年运势失败，请重试'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 80, left: 16, right: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false, // 禁止返回
      child: Scaffold(
        appBar: AppBar(
          title: const Text('补充信息'),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false, // 不显示返回按钮
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormItem(
                        label: '推荐码（选填）',
                        hint: '请输入推荐码',
                        icon: Icons.qr_code_rounded,
                        controller: _referralController,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      FormItem(
                        label: '出生日期',
                        hint: '请选择出生日期',
                        description: '请输入您的阳历出生年月日',
                        icon: Icons.calendar_today_outlined,
                        type: FormFieldType.select,
                        value: _birthDate == null
                            ? null
                            : '${_birthDate!.year}年${_birthDate!.month}月${_birthDate!.day}日',
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 16),
                      FormItem(
                        label: '出生时辰',
                        hint: '请选择出生时辰',
                        description: '您的出生时间将用于个人天时/地势/生历进行核算',
                        icon: Icons.schedule_outlined,
                        type: FormFieldType.select,
                        value: _birthTime,
                        onTap: () => _selectTime(context),
                      ),
                    ],
                  ),
                ),
              ),
              // 底部按钮
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
                    '开启流年运势',
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
      ),
    );
  }
}
