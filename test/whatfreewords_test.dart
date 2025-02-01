import 'package:whatfreewords/whatfreewords.dart';
import 'package:test/test.dart';

void main() {
  test('Coordinate to Words and Back', () {
    final List<double> coord = [51.50844113, -0.116708278];
    final words = coordToWords(coord);
    print(words);
    final backToCoord = wordsToCoord(words);
    print(backToCoord);

    expect(backToCoord[0], closeTo(coord[0], 0.0001));
    expect(backToCoord[1], closeTo(coord[1], 0.0001));
  });
}