import 'dart:async';
import 'package:angular_utility/src/grind.dart' as ang;
import 'package:grinder/grinder.dart';

Future<Null> main(List<String> args) async => grind(args);

@Task('compile scss')
Future sass() async {
  ang.config.sassBuildConfig.package = 'skawa_material_components';
  return await ang.sassBuild();
}

@DefaultTask()
@Task('checking for bad imports')
Future checkimport() async {
  ang.config.importOptimize.packagesToCheck = ['skawa_material_components'];
  await ang.checkImport();
}

@Task('watch scss')
Future sasswatch() async {
  ang.config.sassWatchConfig.package = 'skawa_material_components';
  return await ang.sassWatch();
}
