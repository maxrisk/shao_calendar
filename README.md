# Flutter Calendar

一个基于 Flutter 开发的日历应用。

## 开发环境

- Flutter: 3.27.1
- Dart: 3.3.1
- iOS: 12.0+
- Android: minSdkVersion 21

## 开发设置

1. 复制 `.vscode/launch.json.example` 到 `.vscode/launch.json`
2. 在 `launch.json` 中更新以下配置：
   - `deviceId`: 您的设备 ID
   - `API_BASE_URL`: 对应环境的 API 地址

## 打包说明

### 环境区分

应用支持两种环境：

- 开发环境（development）：用于测试和开发
- 生产环境（production）：用于正式发布

### 构建号生成

项目提供了构建号生成工具方法，位于 `lib/config/app_config.dart`：

```dart
// 生成当前时间的构建号
int buildNumber = AppConfig.generateBuildNumber();
```

你可以通过以下方式在命令行中使用此方法：

```bash
# 使用 dart 命令运行
BUILD_NUMBER=$(dart run -e "import 'lib/config/app_config.dart'; void main() => print(AppConfig.generateBuildNumber());")

# 使用生成的构建号打包
flutter build apk --release --build-number=$BUILD_NUMBER
```

### Android 打包

#### 测试包

```bash
# 手动指定构建号
flutter build apk \
  --release \
  --dart-define=APP_ENV=development \
  --build-name=1.0.0 \
  --build-number=01162147

# 或使用生成的构建号
BUILD_NUMBER=$(dart run -e "import 'lib/config/app_config.dart'; void main() => print(AppConfig.generateBuildNumber());")
flutter build apk \
  --release \
  --dart-define=APP_ENV=development \
  --build-name=1.0.0 \
  --build-number=$BUILD_NUMBER
```

#### 正式包

```bash
flutter build apk \
  --release \
  --dart-define=APP_ENV=production \
  --build-name=1.0.0 \
  --build-number=01162147
```

### iOS 打包

#### 测试包

```bash
flutter build ios \
  --release \
  --dart-define=APP_ENV=development \
  --build-name=1.0.0 \
  --build-number=01162147
```

#### 正式包

```bash
flutter build ios \
  --release \
  --dart-define=APP_ENV=production \
  --build-name=1.0.0 \
  --build-number=01162147
```

### 参数说明

- `--dart-define=APP_ENV`: 环境变量，可选值：
  - `development`: 开发环境
  - `production`: 生产环境
- `--build-name`: 版本号，例如：1.0.0
- `--build-number`: 构建号，格式：MMDDHHMM
  - MM: 月份（01-12）
  - DD: 日期（01-31）
  - HH: 小时（00-23）
  - MM: 分钟（00-59）
  - 例如：01162147 表示 1月16日21时47分

### 自动构建

项目使用 GitHub Actions 进行自动构建：

- `main` 分支：自动构建生产环境包
- `develop` 分支：自动构建开发环境包

构建产物可在 GitHub Actions 的 Artifacts 中下载。

### 注意事项

1. Android 构建号限制：
   - 不能超过 2,100,000,000
   - 必须是整数
   - 使用 MMDDHHMM 格式（8位数字）确保不超过限制
   - 最大值为 12312359（12月31日23时59分）

2. iOS 证书配置：
   - 需要配置开发证书和发布证书
   - 需要配置相应的 Provisioning Profile
   - 最低支持 iOS 12.0

3. 本地开发：
   - 默认使用开发环境配置
   - 可通过 `--dart-define` 切换环境
   - 建议使用 VS Code 的启动配置来管理不同环境

4. 构建号生成工具：
   - 可以使用 `AppConfig.generateBuildNumber()` 生成构建号
   - 生成的构建号格式为 MMDDHHMM（8位数字）
   - 适用于本地开发和手动打包
   - GitHub Actions 中使用时间命令自动生成
   - 确保每次构建的版本号都是唯一的
