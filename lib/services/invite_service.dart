import 'package:dio/dio.dart';
import '../models/invite_record.dart';
import '../models/referral_user_detail.dart';
import 'http_client.dart';

/// 邀请明细服务
class InviteService {
  static final InviteService _instance = InviteService._internal();
  final Dio _dio = HttpClient().dio;

  factory InviteService() {
    return _instance;
  }

  InviteService._internal();

  /// 获取邀请明细列表
  Future<List<InviteRecord>> getInviteRecords() async {
    try {
      final response = await _dio.get('/app/user/referral');
      final data = response.data as Map<String, dynamic>;
      if (data['code'] != 0) {
        throw Exception(data['msg'] ?? '获取邀请明细失败');
      }

      final List<dynamic> recordsData = data['data'] as List? ?? [];
      if (recordsData.isEmpty) {
        return [];
      }

      return recordsData.map((json) {
        try {
          return InviteRecord.fromJson(json);
        } catch (e) {
          print('解析单条邀请记录失败: $e, JSON: $json');
          // 返回一个默认记录，防止整个列表失败
          return const InviteRecord(
            id: 0,
            userId: 0,
            isPaid: false,
          );
        }
      }).toList();
    } on DioException catch (e) {
      print('获取邀请明细失败: ${e.message}');
      return [];
    } catch (e) {
      print('解析邀请明细失败: $e');
      return [];
    }
  }

  /// 获取推荐用户详情
  /// [userId] 用户ID
  Future<ReferralUserDetail?> getReferralUserDetail(int userId) async {
    try {
      final response = await _dio.get('/app/user/referralUser/$userId');
      final data = response.data as Map<String, dynamic>;

      if (data['code'] != 0) {
        throw Exception(data['msg'] ?? '获取用户详情失败');
      }

      if (data['data'] == null) {
        return null;
      }

      return ReferralUserDetail.fromJson(data['data']);
    } on DioException catch (e) {
      print('获取推荐用户详情失败: ${e.message}');
      return null;
    } catch (e) {
      print('解析推荐用户详情失败: $e');
      return null;
    }
  }
}
