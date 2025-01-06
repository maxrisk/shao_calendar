import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 表单项类型
enum FormFieldType {
  /// 输入框
  input,

  /// 选择器
  select,
}

/// 表单项
class FormItem extends StatelessWidget {
  /// 创建表单项
  const FormItem({
    super.key,
    required this.label,
    this.hint,
    this.description,
    this.icon,
    this.type = FormFieldType.input,
    this.controller,
    this.value,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
    this.onTap,
  });

  /// 标签
  final String label;

  /// 提示文本
  final String? hint;

  /// 描述文本
  final String? description;

  /// 图标
  final IconData? icon;

  /// 类型
  final FormFieldType type;

  /// 控制器
  final TextEditingController? controller;

  /// 值
  final String? value;

  /// 键盘类型
  final TextInputType? keyboardType;

  /// 输入格式化
  final List<TextInputFormatter>? inputFormatters;

  /// 最大长度
  final int? maxLength;

  /// 值改变回调
  final ValueChanged<String>? onChanged;

  /// 点击回调
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description!,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
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
            child: type == FormFieldType.input
                ? Row(
                    children: [
                      if (icon != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Icon(
                            icon,
                            size: 20,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      Expanded(
                        child: TextField(
                          controller: controller,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.2,
                          ),
                          decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: icon != null ? 8 : 16,
                              vertical: 14,
                            ),
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          maxLength: maxLength,
                          keyboardType: keyboardType,
                          inputFormatters: inputFormatters,
                          onChanged: onChanged,
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Row(
                        children: [
                          if (icon != null) ...[
                            Icon(
                              icon,
                              size: 20,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            value ?? hint ?? '',
                            style: TextStyle(
                              fontSize: 15,
                              color: value != null
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
    );
  }
}
