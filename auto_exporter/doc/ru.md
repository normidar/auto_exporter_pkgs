
# Auto Exporter

[![pub package](https://img.shields.io/pub/v/auto_exporter.svg)](https://pub.dev/packages/auto_exporter)

Этот проект используется для автоматического экспорта Dart-плагинов.

Создание и особенно экспорт плагинов может быть довольно сложной задачей, и я хорошо понимаю это, так как сам создал несколько плагинов.

С Auto Exporter вы можете автоматически экспортировать плагины, добавляя аннотации.

> Auto Exporter начинался как форк существующего плагина, но с тех пор код значительно изменился. Теперь это совершенно другой проект. (Если вам интересно, сравните его с оригинальным проектом на https://github.com/AlbertoMonteiro/FlutterAutoExport, который, по-видимому, давно не обновлялся.)

> Если у вас возникнут проблемы, создайте issue с упоминанием @normidar. Вы можете писать на японском, китайском или английском языках.

## Использование

Использовать его просто. Добавьте следующий код в ваш `pubspec.yaml`:

```yaml
dependencies:
  auto_exporter_annotation: ^1.0.1

dev_dependencies:
  auto_exporter: ^3.3.0
  build_runner: ^2.4.6
  build_test: ^2.2.0
```

Затем добавьте следующий код в `build.yaml` (если у вас нет `build.yaml`, создайте его в корневом каталоге вашего проекта):

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # Если true, экспортирует все по умолчанию; если false, экспортирует только конкретные файлы
          project_name: <название вашего плагина (пакета)>
```

Если вы хотите экспортировать подпакеты, добавьте поле `sub_packages` в `build.yaml` и укажите список названий подпакетов.

Например:

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # Если true, экспортирует все по умолчанию; если false, экспортирует только конкретные файлы
          project_name: <название вашего плагина (пакета)>
          sub_packages:
            - <название подпакета A>
            - <название подпакета B>
            ...
```

Затем запустите `build_runner`:

```sh
dart run build_runner build  # Для Dart SDK это обычно работает.
```

Для Flutter, возможно, вам нужно будет выполнить это (хотя вышеуказанный код тоже может сработать):

```sh
flutter packages pub run build_runner build  # Для Flutter SDK
```

После выполнения файлы должны быть экспортированы.

## Аннотации для явного экспорта и игнорирования экспорта

- Аннотация `@AutoExport` гарантирует экспорт (даже если `default_export_all` равно false).
- Аннотация `@IgnoreExport` игнорирует экспорт (даже если `default_export_all` равно true).

## Возможности этого плагина реализованы благодаря советам следующих людей:

- @hasimyerlikaya -> IgnoreExport
- @sm-riyadh -> AutoExport

