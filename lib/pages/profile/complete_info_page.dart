import 'package:flutter/material.dart';
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
  String? _birthTime;

  // 时辰列表
  final _timeList = const [
    '子时 (23:00-1:00)',
    '丑时 (1:00-3:00)',
    '寅时 (3:00-5:00)',
    '卯时 (5:00-7:00)',
    '辰时 (7:00-9:00)',
    '巳时 (9:00-11:00)',
    '午时 (11:00-13:00)',
    '未时 (13:00-15:00)',
    '申时 (15:00-17:00)',
    '酉时 (17:00-19:00)',
    '戌时 (19:00-21:00)',
    '亥时 (21:00-23:00)',
  ];

  bool get _isValid =>
      _referralController.text.isNotEmpty &&
      _birthDate != null &&
      _birthTime != null;

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
                _birthTime = time;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('补充信息'),
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormItem(
                      label: '推荐码',
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
                onPressed: _isValid
                    ? () {
                        // TODO: 处理提交
                        Navigator.pop(context);
                      }
                    : null,
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
    );
  }
}
