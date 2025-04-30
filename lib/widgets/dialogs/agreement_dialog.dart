import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/urls.dart';

/// 用户协议与隐私政策弹窗
class AgreementDialog extends StatelessWidget {
  /// 创建用户协议与隐私政策弹窗
  const AgreementDialog({super.key});

  /// 显示用户协议与隐私政策弹窗
  static Future<bool?> show(BuildContext context) async {
    // 在对话框显示之前确保应用程序已经准备好
    if (!WidgetsBinding.instance.isRootWidgetAttached ||
        !Navigator.canPop(context)) {
      // 如果应用尚未完全初始化，延迟显示
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (!context.mounted) return null;

    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AgreementDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        '用户协议与隐私政策',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 15,
                height: 1.3,
                color: colorScheme.onSurface,
              ),
              children: [
                const TextSpan(
                  text: '感谢您使用我们的应用。为了更好地保障您的权益，请您在使用我们的服务前，认真阅读并同意以下协议：',
                ),
                const TextSpan(text: '\n\n'),
                TextSpan(
                  text: '《用户协议》',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchUrl(URLs.userAgreement);
                    },
                ),
                const TextSpan(text: ' 和 '),
                TextSpan(
                  text: '《隐私政策》',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchUrl(URLs.privacyPolicy);
                    },
                ),
                const TextSpan(
                  text:
                      '\n\n点击"同意并进入"，即表示您已阅读并同意上述协议的全部内容。如您不同意，请点击"退出"并停止使用本应用。',
                ),
              ],
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        Row(
          children: [
            Expanded(
              child: FilledButton.tonal(
                onPressed: () {
                  // 首先关闭对话框
                  Navigator.of(context).pop(false);

                  // 强制退出应用
                  _exitApp();
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                ),
                child: Text(
                  '退出',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: () => Navigator.pop(context, true),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '同意并进入',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 强制退出应用程序
  void _exitApp() {
    if (Platform.isAndroid) {
      // Android平台使用SystemNavigator.pop()退出
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      // iOS平台使用exit(0)退出，或者也可以使用以下方式
      // 注意：在iOS上，exit(0)会被认为是应用崩溃，可能会影响App Store评价
      exit(0);
    } else {
      // 其他平台
      SystemNavigator.pop();
    }
  }

  /// 打开URL
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('无法打开链接: $urlString');
    }
  }
}
