import "package:angular/di.dart" show PipeTransform, Pipe;
import 'package:angular/src/common/pipes/invalid_pipe_argument_exception.dart';

/// Based on [seed] provided to the pipe, return a css consumable color
///
/// Returned format: `#somecolor`
///
/// __Usage__:
///
///     <div [style.background-color]="1234 | randomColorize"></div>
///
/// __Limitations__:
///
/// Can only accept seeds of `String` and `int` types also support hexadecimal numbers
@Pipe('hexColorize')
class SkawaHexColorizePipe implements PipeTransform {
  String transform(dynamic seed) {
//    print('seed: $seed');
    if (!_supportedInput(seed)) {
      throw InvalidPipeArgumentException(SkawaHexColorizePipe, seed);
    }
    int hexHash;
    if (seed is String) {
      hexHash = int.tryParse(seed ?? '', radix: 16) ?? (seed ?? '').hashCode;
    } else {
      hexHash = seed.hashCode;
    }
    String hash = hexHash.toRadixString(16);
    while (hash.length < validHashLength.first) {
      hash = '${hash}0';
    }
    while (!validHashLength.contains(hash.length)) {
      hash = hash.substring(1);
    }
    return '#$hash';
  }

  static const validHashLength = const [3, 4, 6, 8];

  bool _supportedInput(dynamic input) => input == null || input is String || input is num;
}
