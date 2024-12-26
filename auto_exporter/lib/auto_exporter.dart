library auto_exporter;

import 'package:build/build.dart';

import 'src/exports_builder.dart';

Builder exportsBuilder(BuilderOptions options) {
  return ExportsBuilder(options: options);
}
