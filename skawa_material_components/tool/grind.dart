import 'dart:async';
import 'package:angular_utility/src/grind.dart' as ang;
import 'package:angular_utility/src/process_start_task.dart' as ang;
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

@Task('run test')
Future test(GrinderContext args) async {
  bool dry = args.invocation.arguments.getFlag('dry');
  ang.ServeProcess serveProcess = new ang.ServeProcess();
  await serveProcess.processStart(pubServe, dry);
  await ang.processStart(normalTest, dry);
  await ang.processStart(angularTest, dry);
  await serveProcess.close();
}

const ang.ProcessInformation pubServe =
    const ang.ProcessInformation('pub', const ['serve', 'test', '--port=8080'], 'Pub serve');

const ang.ProcessInformation normalTest = const ang.ProcessInformation(
    'pub', const ['run', 'test', '-pchrome', '--tags "!(aot)"', '--pub-serve=8080'], 'Run test');

const ang.ProcessInformation angularTest = const ang.ProcessInformation(
    'pub',
    const [
      'run',
      'test',
      'angular_test',
      '--test-arg=-pchrome',
      '--test-arg=--timeout=4x',
      '--test-arg=--exclude-tags=flaky-on-travis',
      '--test-arg=--pub-serve=8080'
    ],
    'Run angular_test');
