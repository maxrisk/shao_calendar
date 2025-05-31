import 'package:flutter/material.dart';

/// 用户等级标签数据
class _LevelData {
  final String label;
  final Color color;

  const _LevelData(this.label, this.color);

  static final Map<int, _LevelData> levels = {
    1: const _LevelData('365服务', Color(0xFFD59E00)),
    2: const _LevelData('3650服务', Color(0xFF6CAA6C)),
    3: const _LevelData('区级代理', Color(0xFFF7A55F)),
    4: const _LevelData('市级代理', Color(0xFF97D5CE)),
    5: const _LevelData('省级代理', Color(0xFFBE9F68)),
  };
}

/// 用户信息卡片组件
class UserInfoCard extends StatelessWidget {
  /// 创建用户信息卡片组件
  const UserInfoCard({
    super.key,
    required this.birthTime,
    required this.userId,
    this.onInviteTap,
    this.promotion,
  });

  /// 生时
  final String birthTime;

  /// 用户ID
  final String userId;

  /// 邀请按钮点击回调
  final VoidCallback? onInviteTap;

  /// 用户等级
  final int? promotion;

  @override
  Widget build(BuildContext context) {
    final levelData = promotion != null && promotion != 0
        ? _LevelData.levels[promotion]
        : null;
    final bool isNormalCard = promotion == 0;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: isNormalCard
              ? Theme.of(context).cardColor
              : (levelData?.color ?? Theme.of(context).cardColor)
                  .withAlpha(217),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // 背景图片 - 只在非普通卡片时显示
            if (!isNormalCard)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 3,
                    child: Image.asset(
                      'assets/images/hexagram_bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 等级标签 - 只在非普通卡片且有levelData时显示
                if (!isNormalCard && levelData != null)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF272636),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        levelData.label,
                        style: TextStyle(
                          color: levelData.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                // 卡片主体
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '生时：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isNormalCard
                                        ? theme.colorScheme.onSurfaceVariant
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  birthTime,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isNormalCard
                                        ? theme.colorScheme.onSurface
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  'ID：',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isNormalCard
                                        ? theme.colorScheme.onSurfaceVariant
                                        : Colors.white.withOpacity(0.7),
                                  ),
                                ),
                                Text(
                                  userId,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isNormalCard
                                        ? theme.colorScheme.onSurface
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // 二维码图片
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onInviteTap,
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                isNormalCard
                                    ? theme.colorScheme.primary
                                    : Colors.white,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(
                                'assets/images/icon_qrcode.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
