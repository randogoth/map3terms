import 'dart:math';
import 'package:test/test.dart';
import 'package:whatfreewords/whatfreewords.dart';

void main() {
  

  group('WhatFreeWords Tests', () {
    test('Coordinate to Words and Back', () {
      final List<double> coord = [51.50844113, -0.116708278];
      final words = coordToWords(coord);
      final backToCoord = wordsToCoord(words);

      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });

    test('Edge Case: Maximum Latitude and Longitude', () {
      final List<double> coord = [90.0, 180.0];
      final words = coordToWords(coord);
      final backToCoord = wordsToCoord(words);

      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });

    test('Edge Case: Minimum Latitude and Longitude', () {
      final List<double> coord = [-90.0, -180.0];
      final words = coordToWords(coord);
      final backToCoord = wordsToCoord(words);

      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });

    test('Invalid Input: Out of Range Coordinates', () {
      expect(() => coordToWords([100.0, 200.0]), throwsA(isA<ArgumentError>()));
      expect(() => coordToWords([-100.0, -200.0]), throwsA(isA<ArgumentError>()));
    });

    test('Invalid Input: Malformed Words String', () {
      expect(() => wordsToCoord("invalid.word.string"), throwsA(isA<ArgumentError>()));
    });

    test('Consistency Check: Multiple Calls Yield Same Result', () {
      final List<double> coord = [34.0522, -118.2437];
      final words1 = coordToWords(coord);
      final words2 = coordToWords(coord);
      expect(words1, equals(words2));
    });

    test('Inverse Mapping: Words Should Convert Back Accurately', () {
      final List<double> coord = [37.7749, -122.4194];
      final words = coordToWords(coord);
      final backToCoord = wordsToCoord(words);
      expect(backToCoord[0], closeTo(coord[0], 0.0001));
      expect(backToCoord[1], closeTo(coord[1], 0.0001));
    });

    test('Randomized Coordinate Encoding and Decoding', () {
      final Random rand = Random();
      for (int i = 0; i < 100; i++) {
        final double lat = -90 + rand.nextDouble() * 180;
        final double lon = -180 + rand.nextDouble() * 360;

        final words = coordToWords([lat, lon]);
        final backToCoord = wordsToCoord(words);

        expect(backToCoord[0], closeTo(lat, 0.0001));
        expect(backToCoord[1], closeTo(lon, 0.0001));
      }
    });

    test('Boundary Conditions', () {
      final List<List<double>> validCoords = [
        [-90.0, 0.0],
        [90.0, 0.0],
        [0.0, -180.0],
        [0.0, 180.0]
      ];

      for (var coord in validCoords) {
        final words = coordToWords(coord);
        final backToCoord = wordsToCoord(words);
        expect(backToCoord[0], closeTo(coord[0], 0.0001));
        expect(backToCoord[1], closeTo(coord[1], 0.0001));
      }

      final List<List<double>> invalidCoords = [
        [-90.1, 0.0],
        [90.1, 0.0],
        [0.0, -180.1],
        [0.0, 180.1]
      ];

      for (var coord in invalidCoords) {
        expect(() => coordToWords(coord), throwsA(isA<ArgumentError>()));
      }
    });

    test('Minimum and Maximum Encodable Values', () {
      final List<double> minCoord = [-89.9999, -179.9999];
      final List<double> maxCoord = [89.9999, 179.9999];

      final wordsMin = coordToWords(minCoord);
      final wordsMax = coordToWords(maxCoord);

      final backToCoordMin = wordsToCoord(wordsMin);
      final backToCoordMax = wordsToCoord(wordsMax);

      expect(backToCoordMin[0], closeTo(minCoord[0], 0.0001));
      expect(backToCoordMin[1], closeTo(minCoord[1], 0.0001));
      expect(backToCoordMax[0], closeTo(maxCoord[0], 0.0001));
      expect(backToCoordMax[1], closeTo(maxCoord[1], 0.0001));
    });

    test('Invalid Word Combination', () {
      expect(() => wordsToCoord("valid.valid.invalid"), throwsA(isA<ArgumentError>()));
      expect(() => wordsToCoord("invalid.valid.valid"), throwsA(isA<ArgumentError>()));
      expect(() => wordsToCoord("valid.invalid.valid"), throwsA(isA<ArgumentError>()));
    });


  });
}