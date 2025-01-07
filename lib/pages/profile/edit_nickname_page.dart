import 'package:flutter/material.dart';

/// 昵称编辑页面
class EditNicknamePage extends StatefulWidget {
  /// 创建昵称编辑页面
  const EditNicknamePage({
    super.key,
    this.initialValue,
  });

  /// 初始昵称
  final String? initialValue;

  @override
  State<EditNicknamePage> createState() => _EditNicknamePageState();
}

class _EditNicknamePageState extends State<EditNicknamePage> {
  late final TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _validateInput(_controller.text);
    _controller.addListener(() {
      _validateInput(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateInput(String value) {
    setState(() {
      _isValid = value.trim().isNotEmpty && value.length <= 20;
    });
  }

  void _handleSave() {
    final value = _controller.text.trim();
    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('昵称不能为空'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('修改昵称'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isValid ? _handleSave : null,
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.primary,
              disabledForegroundColor: colorScheme.onSurfaceVariant,
            ),
            child: const Text(
              '保存',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outlineVariant.withAlpha(50),
                ),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.2,
                ),
                decoration: InputDecoration(
                  hintText: '请输入昵称',
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
                maxLength: 20,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  if (_isValid) {
                    _handleSave();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                '昵称长度不超过20个字符',
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
