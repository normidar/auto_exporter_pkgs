import 'package:auto_exporter/src/exports_builder.dart';
import 'package:build/build.dart';

Builder exportsBuilder(BuilderOptions options) {
  return ExportsBuilder(options: options);
}
