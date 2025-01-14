import 'package:flutter/material.dart';

class UserAgreementPage extends StatelessWidget {
  const UserAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('用户协议'),
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
              '邵氏先天历用户协议',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '欢迎使用邵氏先天历！',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              '1. 服务内容',
              '邵氏先天历为用户提供传统历法查询、运势分析等服务。我们会持续更新和完善服务内容，以提供更好的用户体验。',
              colorScheme,
            ),
            _buildSection(
              '2. 用户注册',
              '用户需要提供真实、准确的个人信息进行注册。用户应妥善保管账号和密码，因账号密码保管不当造成的损失由用户自行承担。',
              colorScheme,
            ),
            _buildSection(
              '3. 用户行为规范',
              '用户在使用本服务时应遵守中华人民共和国相关法律法规，不得利用本服务从事违法违规活动。',
              colorScheme,
            ),
            _buildSection(
              '4. 知识产权',
              '邵氏先天历的所有内容，包括但不限于文字、图片、音频、视频、软件、程序、数据等，均受知识产权法律法规保护。',
              colorScheme,
            ),
            _buildSection(
              '5. 服务变更与终止',
              '我们保留随时修改或终止服务的权利。服务变更或终止前，我们会通过适当方式通知用户。',
              colorScheme,
            ),
            _buildSection(
              '6. 免责声明',
              '邵氏先天历提供的运势分析等服务仅供参考，不作为任何决策的依据。用户因使用本服务而产生的任何直接或间接损失，我们不承担任何责任。',
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
