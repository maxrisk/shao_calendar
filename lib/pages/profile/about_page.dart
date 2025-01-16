import 'package:flutter/material.dart';
import '../../widgets/list/list_group.dart';
import '../../widgets/list/list_cell.dart';
import 'user_agreement_page.dart';
import 'privacy_policy_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('关于我们'),
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            /// App Logo
            Image.asset(
              'assets/images/logo.jpg', // 请确保添加logo图片资源
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16),
            const Text(
              '邵氏先天历',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            ListGroup(
              children: [
                ListCell(
                  title: '用户协议',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserAgreementPage(),
                      ),
                    );
                  },
                ),
                ListCell(
                  title: '隐私政策',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                '邵氏先天历是一款专注于传统历法研究与应用的软件。我们致力于将古老的智慧以现代化的方式呈现，帮助用户更好地理解和运用传统历法的奥秘。',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withAlpha(153),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '© 2024 邵氏先天历 版权所有',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface.withAlpha(102),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}