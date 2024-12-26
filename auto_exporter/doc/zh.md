
# Auto Exporter

[![pub package](https://img.shields.io/pub/v/auto_exporter.svg)](https://pub.dev/packages/auto_exporter)

这个项目用于自动导出Dart包中的定义。

导出包中的定义是一件繁琐的事，我自己也创建了几个插件，所以我对此深有体会。

使用 Auto Exporter，你可以通过添加注解来自动导出插件。

> Auto Exporter 最初是作为一个现有插件的分支，但代码从那时起已经发生了显著变化。现在它已经成为一个完全不同的实体。（如果你有兴趣，可以将其与原始项目进行比较，网址是 https://github.com/AlbertoMonteiro/FlutterAutoExport，该项目似乎已经有一段时间没有更新了。）

> 如果你遇到任何问题，请提及 @normidar 创建一个 issue。你可以用日语、中文或英文编写。

## 使用方法

使用非常简单。将以下代码添加到你的 `pubspec.yaml` 中：

```yaml
dependencies:
  auto_exporter_annotation: ^1.0.1

dev_dependencies:
  auto_exporter: ^3.3.0
  build_runner: ^2.4.6
  build_test: ^2.2.0
```

然后，将以下代码添加到 `build.yaml` 中（如果你没有 `build.yaml`，请在项目根目录下创建它）：

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # 如果为 true，默认导出所有文件；如果为 false，仅导出特定文件
          project_name: <你的插件（包）名称>
```

如果你想导出子包，请在 `build.yaml` 中添加 `sub_packages` 字段并指定子包名称列表。

例如：

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # 如果为 true，默认导出所有文件；如果为 false，仅导出特定文件
          project_name: <你的插件（包）名称>
          sub_packages:
            - <子包 A 名称>
            - <子包 B 名称>
            ...
```

然后，运行 `build_runner`：

```sh
dart run build_runner build  # 对于 Dart SDK，通常这样可以正常构建。
```

对于 Flutter，你可能需要运行这个（尽管上面的代码可能也有效）：

```sh
flutter packages pub run build_runner build  # 对于 Flutter SDK
```

运行完成后，文件应该已经导出。

## 显式导出和忽略导出的注解

- 使用 `@AutoExport` 注解可以确保导出（即使 `default_export_all` 为 false 时也会导出）。
- 使用 `@IgnoreExport` 注解可以忽略导出（即使 `default_export_all` 为 true 时也不会导出）。

## 这个插件的功能得益于以下人员的建议：

- @hasimyerlikaya -> IgnoreExport
- @sm-riyadh -> AutoExport

