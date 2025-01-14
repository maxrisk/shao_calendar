import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私政策'),
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '邵氏先天历隐私政策',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '我们非常重视您的隐私保护。本隐私政策说明我们如何收集、使用和保护您的个人信息。',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. 信息收集',
              '我们收集的信息包括：\n• 基本信息：姓名、手机号码\n• 设备信息：设备型号、操作系统版本\n• 使用数据：使用频率、功能偏好',
              colorScheme,
            ),
            _buildSection(
              '2. 信息使用',
              '我们收集的信息将用于：\n• 提供和改进服务\n• 个性化用户体验\n• 发送服务通知\n• 提供客户支持',
              colorScheme,
            ),
            _buildSection(
              '3. 信息安全',
              '我们采用业界标准的安全措施保护您的个人信息，包括数据加密、访问控制等技术手段。',
              colorScheme,
            ),
            _buildSection(
              '4. 信息共享',
              '除非获得您的明确同意或法律法规要求，我们不会与第三方分享您的个人信息。',
              colorScheme,
            ),
            _buildSection(
              '5. Cookie使用',
              '我们使用Cookie和类似技术来改善用户体验，您可以通过浏览器设置控制Cookie。',
              colorScheme,
            ),
            _buildSection(
              '6. 未成年人保护',
              '我们建议未满18岁的未成年人在监护人指导下使用我们的服务。如发现误收集未成年人信息，我们会及时删除。',
              colorScheme,
            ),
            _buildSection(
              '7. 隐私政策更新',
              '我们可能会不时更新本隐私政策，更新后的政策将在应用内发布。继续使用我们的服务即表示您同意接受更新后的隐私政策。',
              colorScheme,
            ),
            _buildSection(
              '8. 联系我们',
              '如果您对本隐私政策有任何疑问，请通过应用内的"联系我们"功能与我们联系。',
              colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurface.withAlpha(204),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
