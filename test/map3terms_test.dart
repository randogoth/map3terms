import 'package:test/test.dart';
import 'dart:math';
import 'package:map3terms/map3terms.dart';

void main() {
  

  group('map3terms Tests', () {
    test('Coordinate to Words and Back', () async {
      final List<double> coord = [51.50844113, -0.116708278];
      final words = await coordToWords(coord);
      final backToCoord = await wordsToCoord(words);

      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });

    test('Edge Case: Maximum Latitude and Longitude', () async {
      final List<double> coord = [90.0, 180.0];
      final words = await coordToWords(coord);
      final backToCoord = await wordsToCoord(words);

      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });

    test('Edge Case: Minimum Latitude and Longitude', () async {
      final List<double> coord = [-90.0, -180.0];
      final words = await coordToWords(coord);
      final backToCoord = await wordsToCoord(words);

      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });

    test('Invalid Input: Out of Range Coordinates', () async {
      expect(() => coordToWords([100.0, 200.0]), throwsA(isA<ArgumentError>()));
      expect(() => coordToWords([-100.0, -200.0]), throwsA(isA<ArgumentError>()));
    });

    test('Invalid Input: Malformed Words String', () async {
      expect(() => wordsToCoord("invalid.word.string"), throwsA(isA<ArgumentError>()));
    });

    test('Consistency Check: Multiple Calls Yield Same Result', () async {
      final List<double> coord = [34.0522, -118.2437];
      final words1 = await coordToWords(coord);
      final words2 = await coordToWords(coord);
      expect(words1, equals(words2));
    });

    test('Inverse Mapping: Words Should Convert Back Accurately', () async {
      final List<double> coord = [37.7749, -122.4194];
      final words = await coordToWords(coord);
      final backToCoord = await wordsToCoord(words);
      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });
  });
}