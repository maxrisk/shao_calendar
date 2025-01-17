#!/bin/bash

# 加载环境变量
source .env

# 运行 Flutter 应用
flutter run \
  --dart-define=APP_ENV=development \
  --dart-define=API_BASE_URL=$API_BASE_URL 