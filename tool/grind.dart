import 'dart:async';
import 'package:angular_utility/src/grind.dart';

Future<Null> main(List<String> args) async {
  config.importOptimize.packagesToCheck.addAll(new List.from(args));
  checkImport();
}
