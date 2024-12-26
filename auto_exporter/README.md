[日本語](./doc/ja.md) | [简体中文](./doc/zh.md) | [Русский](./doc/ru.md) | [한국어](./doc/ko.md) | [العربية](./doc/ar.md)

# Auto Exporter

[![pub package](https://img.shields.io/pub/v/auto_exporter.svg)](https://pub.dev/packages/auto_exporter)

This project is used to automatically export Dart Classes and Enums etc.

Creating and especially exporting can be quite difficult, and I understand this well as I have created several plugins myself.

With Auto Exporter, you can automatically export plugins by adding annotations.

> Auto Exporter started as a fork of an existing plugin, but the code has evolved significantly since then. It has now become a completely different entity. (If you're interested, compare it with the original project at https://github.com/AlbertoMonteiro/FlutterAutoExport, which does not appear to have been updated recently.)

> If you encounter any issues, please create an issue mentioning @normidar. You can write in Japanese, Chinese, or English.

## Usage

Using it is simple. Add the following code to your `pubspec.yaml`:

```yaml
dependencies:
  auto_exporter_annotation: ^1.0.1

dev_dependencies:
  auto_exporter: ^3.3.0
  build_runner: ^2.4.6
  build_test: ^2.2.0
```

Then, add the following code to `build.yaml` (if you don't have `build.yaml`, create it at the root of your project):

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # If true, exports everything by default; if false, only specific files are exported
          project_name: <your plugin (package) name>
```

If you want to export sub-packages, add the `sub_packages` field to `build.yaml` and specify a list of sub-package names.

For example:

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # If true, exports everything by default; if false, only specific files are exported
          project_name: <your plugin (package) name>
          sub_packages:
            - <sub-package A name>
            - <sub-package B name>
            ...
```

Then, run `build_runner`:

```sh
dart run build_runner build  # For Dart SDK, this usually works.
```

For Flutter, you might need to run this (though the above might also work):

```sh
flutter packages pub run build_runner build  # For Flutter SDK
```

After running, the files should be exported.

## Annotations for Explicit Export and Ignoring Export

- The `@AutoExport` annotation ensures export (even if `default_export_all` is false).
- The `@IgnoreExport` annotation ignores export (even if `default_export_all` is true).

## This plugin's features are thanks to the advice of:

- @hasimyerlikaya -> IgnoreExport
- @sm-riyadh -> AutoExport

## TODO:

> PR is well come, @normidar first please.

- auto choose show and hide to make it shorter
- A way to export a file or hide a file
