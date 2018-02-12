import "package:angular2/di.dart" show PipeTransform, Pipe;
import 'package:angular2/src/common/pipes/invalid_pipe_argument_exception.dart';

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
@Pipe('randomColorize')
class SkawaRandomColorizePipe implements PipeTransform {
  String transform(dynamic seed) {
    if (!_supportedInput(seed)) {
      throw new InvalidPipeArgumentException(SkawaRandomColorizePipe, seed);
    }
    int hexHash;
    if (seed is String) {
      hexHash = int.parse(seed, radix: 16, onError: (s) => s.hashCode);
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

  bool _supportedInput(dynamic input) => input is String || input is num;
}
