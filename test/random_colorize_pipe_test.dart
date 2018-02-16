import 'package:angular/src/common/pipes/invalid_pipe_argument_exception.dart';
import 'package:skawa_components/src/pipes/random_colorize_pipe.dart';
import 'package:test/test.dart';

final Matcher throwsATypeError = throwsA(new isInstanceOf<TypeError>());

final Matcher throwsAnInvalidPipeArgumentException = throwsA(new isInstanceOf<InvalidPipeArgumentException>());

main() {
  group('RandomColorizePipe | ', () {
    SkawaRandomColorizePipe pipe;
    final int intSeed = 1234;
    final String stringSeed = 'seed';
    final String hexSeed = '2cbe4e';
    setUp(() => pipe = new SkawaRandomColorizePipe());
    test('accepts int', () {
      expect(() {
        pipe.transform(intSeed);
      }, returnsNormally);
    });
    test('accepts String', () {
      expect(() => pipe.transform(stringSeed), returnsNormally);
    });
    test('throws for types not int or String', () {
      expect(() => pipe.transform(new Object()), throwsAnInvalidPipeArgumentException);
    });
    test('returns same color for the same int seed', () {
      String a = pipe.transform(intSeed);
      String b = pipe.transform(intSeed);
      expect(a, allOf(const isInstanceOf<String>(), b));
    });
    test('returns valid css color', () {
      String a = pipe.transform(intSeed);
      expect(a, startsWith('#'));
      expect(SkawaRandomColorizePipe.validHashLength.contains(a.length - 1), isTrue);
    });
    test('returns same color for the same string seed', () {
      String a = pipe.transform(stringSeed);
      String b = pipe.transform(stringSeed);
      expect(a, b);
    });
    test('keeps hex numbers', () {
      String b = pipe.transform(hexSeed);
      expect(b, contains(hexSeed));
    });
    test("output can't be 6 length", () {
      String b = pipe.transform(hexSeed.substring(1));
      expect(b, hasLength(5));
    });
  });
}
