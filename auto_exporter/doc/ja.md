# Auto Exporter

[![pub package](https://img.shields.io/pub/v/auto_exporter.svg)](https://pub.dev/packages/auto_exporter)

このプロジェクトは自動的にDartプラグインをエクスポートするために使われます。

プラグインを作る特にエクスポートするのは大変だと思います、自分もいくつのプラグインを作っているのでわかります。

Auto Exporterを使えばアノテーションをつけることで自動的にエクスポートしてくれます。

> Auto Exporterは元々あるプラグインをフォークして作っていましたが、フォークした当初とのコードが全然違うものに変わったので完全に別物と言っていいでしょう。 (興味あれば https://github.com/AlbertoMonteiro/FlutterAutoExport と比較してみてください、今の時点ではあのプロジェクトが長く更新されていないように見えます。)

> もし何か問題がありましたら @normidar のメンションでイシューを作ってください。（日本語、中国語、英語どちらでも大丈夫です）

## 使い方

使い方は簡単です、以下のコードを`pubspec.yaml`に追加してください：

```
dependencies:
  auto_exporter_annotation: ^1.0.1

dev_dependencies:
  auto_exporter: ^3.3.0
  build_runner: ^2.4.6
  build_test: ^2.2.0
```

そして、以下のコードを`build.yaml`に追加してください（もし`build.yaml`がない場合は`build.yaml`をプロジェクトのルートに作成してください）：

```
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # trueの場合、デフォルトで全部をエクスポートする、falseの場合、特定のファイルのみエクスポートする
          project_name: <あなたのプラグイン(パッケージ)の名前>
```

サブパッケージをエクスポートする場合は、`sub_packages`フィールドを`build.yaml`に追加してサブパッケージの名前のリストを指定してください。

例えば：

```
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # trueの場合、デフォルトで全部をエクスポートする、falseの場合、特定のファイルのみエクスポートする
          project_name: <あなたのプラグイン(パッケージ)の名前>
          sub_packages:
            - <エクスポートするサブパッケージAの名前>
            - <エクスポートするサブパッケージBの名前>
            ...
```

そして、`build_runner`を実行してください：

```
dart run build_runner build  # Dart SDK ほとんどの場合これでうまくビルドできます。
```

もしFlutterの場合これが必要かもしれません（実は上のコードもできると思います）：

```
flutter packages pub run build_runner build  # Flutter SDK 
```

実行完了後にファイルはエクポートされているはずです。

## 明示的にエクスポート、エクスポートを無視できるアノテーション

- `@AutoExport`アノテーションをつけることでエクスポートを確実にできます。（`default_export_all`が`false`の場合でもエクスポート**する**）
- `@IgnoreExport`アノテーションをつけることでエクスポートを無視できます。（`default_export_all`が`true`の場合でもエクスポート**しない**）

## このプラグインの機能は以下の人たちの助言でできています：

- @hasimyerlikaya -> IgnoreExport
- @sm-riyadh -> AutoExport
