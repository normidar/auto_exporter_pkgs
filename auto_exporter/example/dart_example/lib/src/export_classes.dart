import 'package:auto_exporter_annotation/auto_exporter_annotation.dart';

@AutoExport()
class AlwaysExport {}

@IgnoreExport()
class DoNoExport {}

class DefaultExport {}

final finalNormal = 'Normal';

enum MyEnum {
  value1,
  value2,
}

void abc() {}
