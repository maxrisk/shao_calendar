import 'package:flutter/material.dart';

/// 标签组件
class Label extends StatelessWidget {
  /// 创建标签组件
  const Label({
    super.key,
    required this.text,
  });

  /// 标签文本
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: AssetImage('assets/images/label_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
