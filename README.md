# flutter_butailing

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 同步gitmodule
# 进入到vernder/flutter_librqbit执行集成脚本
```
cd vendor/flutter_rqbit && flutter_rust_bridge_codegen integrate && flutter pub get && cd rust cargo build

```

实时监听进行桥接将rust转换为dart转换：
```
flutter_rust_bridge_codegen generate --watch
```

rust目录中执行cargo进行编译验证
```
    cargo build
```

集成：


基础编译依赖：
flutter:

```
flutter pub add flutter_rust_bridge
·
```

