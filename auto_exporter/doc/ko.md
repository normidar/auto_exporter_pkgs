
# Auto Exporter

[![pub package](https://img.shields.io/pub/v/auto_exporter.svg)](https://pub.dev/packages/auto_exporter)

이 프로젝트는 Dart 플러그인을 자동으로 내보내기 위해 사용됩니다.

플러그인을 만들고 특히 내보내는 것은 매우 어려울 수 있습니다. 저도 몇 개의 플러그인을 만들었기 때문에 이를 잘 알고 있습니다.

Auto Exporter를 사용하면 주석을 추가하여 플러그인을 자동으로 내보낼 수 있습니다.

> Auto Exporter는 원래 존재하던 플러그인을 포크하여 시작했지만, 이후 코드가 상당히 변형되었습니다. 이제는 완전히 다른 프로젝트라고 할 수 있습니다. (관심이 있다면 https://github.com/AlbertoMonteiro/FlutterAutoExport 와 비교해보세요. 현재 그 프로젝트는 오랫동안 업데이트되지 않은 것처럼 보입니다.)

> 문제가 발생하면 @normidar를 멘션하여 issue를 생성해 주세요. 일본어, 중국어, 영어로 작성 가능합니다.

## 사용법

사용 방법은 간단합니다. `pubspec.yaml`에 다음 코드를 추가하세요:

```yaml
dependencies:
  auto_exporter_annotation: ^1.0.1

dev_dependencies:
  auto_exporter: ^3.3.0
  build_runner: ^2.4.6
  build_test: ^2.2.0
```

그런 다음, `build.yaml`에 다음 코드를 추가하세요 (만약 `build.yaml`이 없다면 프로젝트 루트에 생성하세요):

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # true인 경우, 기본적으로 모든 파일을 내보냅니다; false인 경우, 특정 파일만 내보냅니다
          project_name: <플러그인(패키지) 이름>
```

서브 패키지를 내보내려면, `build.yaml`에 `sub_packages` 필드를 추가하고 서브 패키지 이름 목록을 지정하세요.

예를 들어:

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # true인 경우, 기본적으로 모든 파일을 내보냅니다; false인 경우, 특정 파일만 내보냅니다
          project_name: <플러그인(패키지) 이름>
          sub_packages:
            - <내보낼 서브 패키지 A 이름>
            - <내보낼 서브 패키지 B 이름>
            ...
```

그런 다음, `build_runner`를 실행하세요:

```sh
dart run build_runner build  # Dart SDK의 경우 대부분 이 명령어로 빌드가 잘 됩니다.
```

Flutter의 경우 다음 명령어가 필요할 수 있습니다 (위의 명령어도 작동할 수 있습니다):

```sh
flutter packages pub run build_runner build  # Flutter SDK의 경우
```

실행이 완료되면 파일이 내보내졌을 것입니다.

## 명시적 내보내기 및 내보내기 무시 주석

- `@AutoExport` 주석을 사용하여 내보내기를 보장할 수 있습니다. (`default_export_all`이 false인 경우에도 내보냅니다.)
- `@IgnoreExport` 주석을 사용하여 내보내기를 무시할 수 있습니다. (`default_export_all`이 true인 경우에도 내보내지 않습니다.)

## 이 플러그인의 기능은 다음 분들의 조언으로 구현되었습니다:

- @hasimyerlikaya -> IgnoreExport
- @sm-riyadh -> AutoExport

