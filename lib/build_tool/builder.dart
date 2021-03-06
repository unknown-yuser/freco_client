import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:scratch_space/scratch_space.dart';
import 'package:path/path.dart' as p;

Builder frecoMessageBuilderFactory(BuilderOptions options) =>
    FrecoMessageBuilder(options);

class FrecoMessageBuilder implements Builder {
  final BuilderOptions options;
  final List<String> deleteFileList = <String>[];

  FrecoMessageBuilder(this.options);

  late final _scratch = Resource(() => ScratchSpace(),
      dispose: (o) => o.delete(),
      beforeExit: () => {
            for (final file in deleteFileList) {File(file).delete()}
          });
  final _extensions = <String>[
    '.pbjson.dart',
    '.pb.dart',
    '.pbenum.dart',
  ];

  @override
  Map<String, List<String>> get buildExtensions => {'.proto': _extensions};

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final space = await buildStep.fetchResource(_scratch);
    final protoAssets = await buildStep
        .findAssets(Glob('**/*.proto'))
        .fold<List<AssetId>>(
            <AssetId>[], (previous, element) => previous..add(element));
    await space.ensureAssets(protoAssets, buildStep);

    final file = space.fileFor(buildStep.inputId);
    if (!file.existsSync()) {
      print("${file.path} は存在しませんでした。");
      return;
    }

    final dirpath = Directory.current.path;
    final protoDir = p.relative(p.dirname(file.path), from: dirpath);

    final process = await Process.run(
        'protoc',
        [
          '--dart_out=grpc:$protoDir',
          '-I$protoDir',
          p.relative(file.path, from: dirpath)
        ],
        workingDirectory: dirpath);

    final code = process.exitCode;
    if (code != 0) {
      print(process.stderr);
      return;
    }

    for (final ext in _extensions) {
      final extAssetId = buildStep.inputId.changeExtension(ext);
      final extOutputFile = space.fileFor(extAssetId);

      if (await extOutputFile.exists()) {
        await space.copyOutput(extAssetId, buildStep);
        final srcPath = File(extAssetId.path);
        final destPathSegments = <String>[
          ...options.config["output"].split("/"),
          p.basename(extAssetId.path)
        ];
        await srcPath.copy(p.joinAll(destPathSegments));
        deleteFileList.add(extAssetId.path);
      } else {
        print('No output for: ${extAssetId.path}: $extOutputFile.path} found');
      }
    }
  }
}
