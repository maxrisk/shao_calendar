import 'package:flutter/material.dart';

/// 爻位选择器组件
class YaoSelector extends StatelessWidget {
  /// 创建爻位选择器组件
  const YaoSelector({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  /// 当前选中的爻位索引
  final int selectedIndex;

  /// 选择回调
  final ValueChanged<int> onSelected;

  /// 爻位名称列表
  static const _yaoNames = ['初爻', '二爻', '三爻', '四爻', '五爻', '六爻'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 40) / 6;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_yaoNames.length, (index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onSelected(index),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isSelected)
                      Container(
                        width: itemWidth + 8,
                        height: itemWidth + 8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Container(
                      width: itemWidth,
                      height: itemWidth,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/yao_bg.png'),
                          fit: BoxFit.contain,
                        ),
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          _yaoNames[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
