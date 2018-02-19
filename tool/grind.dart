import 'dart:async';
import 'package:angular_utility/src/grind.dart' as ang;
import 'package:grinder/grinder.dart';

Future<Null> main(List<String> args) async => grind(args);

@Task('compile scss')
Future sass() async => await ang.sassBuild();


@Task('compile scss')
Future checkimport() async {
  ang.config.importOptimize.packagesToCheck=['skawa_components'];
  await ang.checkImport();
}

@Task('compile scss')
Future sasswatch() async => await ang.sassWatch();
