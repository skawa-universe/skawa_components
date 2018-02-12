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
/// Can only accept seeds of `String` and `int` types
@Pipe('randomColorize')
class SkawaRandomColorizePipe implements PipeTransform {
  String transform(dynamic seed) {
    if (!_supportedInput(seed)) {
      throw new InvalidPipeArgumentException(SkawaRandomColorizePipe, seed);
    }
    num hash;
    if (seed is String) {
      hash = seed.hashCode % 1000000;
    } else if (seed is num) {
      hash = seed % 1000000;
    }
    return '#$hash';
  }

  bool _supportedInput(dynamic input) => input is String || input is num;
}