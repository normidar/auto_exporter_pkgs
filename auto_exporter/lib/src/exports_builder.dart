import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';
import 'package:pub_semver/pub_semver.dart';

/// the ExportsBuilder will create the file to
/// export all dart files
class ExportsBuilder implements Builder {
  ExportsBuilder({required this.options});

  BuilderOptions options;

  @override
  Map<String, List<String>> get buildExtensions {
    return {
      r'$lib$': ['$packageName.dart'],
    };
  }

  List<String> get exportSubPackage =>
      (options.config['sub_packages'] as List?)?.cast<String>() ?? [];

  bool get isDefaultExportAll =>
      options.config['default_export_all'] as bool? ?? true;
  String get packageName =>
      options.config['project_name'] as String? ?? 'exports';

  @override
  Future<void> build(BuildStep buildStep) async {
    final exports = buildStep.findAssets(Glob('lib/**/*.dart'));

    final expList = <String>[];
    final content = <String>[];
    await for (final exportLibrary in exports) {
      // each file

      final con = await buildStep.readAsString(exportLibrary);
      // to check has `part of`
      // check the runtime type to develop auto_exporter.
      final ast = parseString(content: con).unit.childEntities;

      final exportUri = exportLibrary.uri.path;
      if (exportUri != 'package:$packageName/$packageName.dart') {
        // not the file for exports

        if (ast.whereType<PartOfDirective>().isEmpty) {
          // no `part of`

          final expString = getExpString(ast, exportUri);
          if (expString != null) {
            expList.add(expString);
          }
        }
      }
    }
    for (final e in exportSubPackage) {
      expList.add("export 'package:$e/$e.dart';");
    }
    expList.add('');

    content.addAll(expList);
    if (content.isNotEmpty) {
      content.sort();
      await buildStep.writeAsString(
        AssetId(buildStep.inputId.package, 'lib/$packageName.dart'),
        DartFormatter(
          languageVersion: Version(3, 7, 0),
        ).format(content.join('\n')),
      );
    }
  }

  /// get export string:
  /// If default export all:
  ///   only ignore the `@IgnoreExport()`
  /// If default not export all:
  ///   only export the `@AutoExport()`
  String? getExpString(Iterable<SyntacticEntity> ast, String exportUri) {
    var ignoreCount = 0;
    var exportCount = 0;

    final ignoreList = <String>[];
    final exportList = <String>[];
    final normalList = <String>[];

    // class
    ast.whereType<NamedCompilationUnitMember>().forEach((e) {
      final meta = e.metadata.map((e) => e.toString());
      if (meta.contains('@IgnoreExport()')) {
        ignoreCount++;
        ignoreList.add(e.name.toString());
      } else if (meta.contains('@AutoExport()')) {
        exportCount++;
        exportList.add(e.name.toString());
      } else {
        normalList.add(e.name.toString());
      }
    });

    // variable
    ast.whereType<TopLevelVariableDeclaration>().forEach((e) {
      final meta = e.metadata.map((e) => e.toString());
      if (meta.contains('@IgnoreExport()')) {
        ignoreCount++;
        ignoreList.add(e.variables.variables.first.name.toString());
      } else if (meta.contains('@AutoExport()')) {
        exportCount++;
        exportList.add(e.variables.variables.first.name.toString());
      } else {
        normalList.add(e.variables.variables.first.name.toString());
      }
    });

    if (isDefaultExportAll) {
      if (ignoreCount == 0) {
        return "export 'package:$exportUri';";
      }

      // only take not ignore class
      final toExpLst = [...normalList, ...exportList].join(', ');
      if (toExpLst.isNotEmpty) {
        return "export 'package:$exportUri' show $toExpLst;";
      } else {
        return null;
      }
    } else {
      // default unexport all
      if (exportCount == 0) {
        return null;
      }

      // only take export classes
      final toExpLst = exportList.join(',');
      return "export 'package:$exportUri' show $toExpLst;";
    }
  }
}
