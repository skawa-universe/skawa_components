import 'dart:async';
import 'package:angular_utility/src/grind.dart' as ang;
import 'package:grinder/grinder.dart';

Future<Null> main(List<String> args) async {
//  config.importOptimize.packagesToCheck.addAll(new List.from(args));
//  checkImport();
  grind(args);
}

@Task('compile scss')
Future sass() async {
  await ang.sass();
}
