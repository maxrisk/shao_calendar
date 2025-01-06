/// 订单类型
enum CommissionOrderType {
  /// 直接推荐奖励
  direct(label: '直接推荐奖励'),

  /// 间接推荐奖励
  indirect(label: '间接推荐奖励'),

  /// 提现
  withdraw(label: '提现');

  const CommissionOrderType({required this.label});

  /// 标签文本
  final String label;
}

/// 订单详情
class CommissionOrder {
  /// 创建订单详情
  const CommissionOrder({
    required this.type,
    required this.amount,
    required this.orderNo,
    required this.dateTime,
    required this.description,
    this.cardNo,
  });

  /// 订单类型
  final CommissionOrderType type;

  /// 金额
  final double amount;

  /// 订单编号
  final String orderNo;

  /// 时间
  final String dateTime;

  /// 说明
  final String description;

  /// 卡号（提现时使用）
  final String? cardNo;
}
