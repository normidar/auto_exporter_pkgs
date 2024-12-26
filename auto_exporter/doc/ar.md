
# Auto Exporter

[![pub package](https://img.shields.io/pub/v/auto_exporter.svg)](https://pub.dev/packages/auto_exporter)

يُستخدم هذا المشروع لتصدير مكونات Dart الإضافية تلقائيًا.

إن إنشاء المكونات الإضافية وتحديدًا تصديرها يمكن أن يكون مهمة صعبة للغاية. أفهم هذا جيدًا لأنني أنشأت العديد من المكونات الإضافية بنفسي.

مع Auto Exporter، يمكنك تصدير المكونات الإضافية تلقائيًا عن طريق إضافة التعليقات التوضيحية.

> بدأ Auto Exporter كتشعب من مكون إضافي موجود بالفعل، لكن الكود تغير كثيرًا منذ ذلك الحين. الآن أصبح مشروعًا مختلفًا تمامًا. (إذا كنت مهتمًا، يمكنك مقارنته بالمشروع الأصلي على https://github.com/AlbertoMonteiro/FlutterAutoExport، الذي يبدو أنه لم يتم تحديثه منذ فترة طويلة.)

> إذا واجهت أي مشاكل، فيرجى إنشاء issue بذكر @normidar. يمكنك الكتابة باليابانية أو الصينية أو الإنجليزية.

## كيفية الاستخدام

الاستخدام بسيط. أضف الكود التالي إلى `pubspec.yaml` الخاص بك:

```yaml
dependencies:
  auto_exporter_annotation: ^1.0.1

dev_dependencies:
  auto_exporter: ^3.3.0
  build_runner: ^2.4.6
  build_test: ^2.2.0
```

ثم أضف الكود التالي إلى `build.yaml` (إذا لم يكن لديك `build.yaml`، قم بإنشائه في جذر مشروعك):

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # إذا كانت true، يتم تصدير كل شيء افتراضيًا؛ إذا كانت false، يتم تصدير ملفات محددة فقط
          project_name: <اسم المكون الإضافي (الحزمة) الخاص بك>
```

إذا كنت ترغب في تصدير الحزم الفرعية، أضف حقل `sub_packages` إلى `build.yaml` وحدد قائمة بأسماء الحزم الفرعية.

على سبيل المثال:

```yaml
targets:
  $default:
    builders:
      auto_exporter:
        options:
          default_export_all: true # إذا كانت true، يتم تصدير كل شيء افتراضيًا؛ إذا كانت false، يتم تصدير ملفات محددة فقط
         
