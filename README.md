![bunny](bunny.png)

# Map3Terms

[![](http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png")](http://www.wtfpl.net/)

This is the Dart port of the original [JavaScript implementation](https://github.com/pballett/map3terms) of a small but ingenious test to show how one might reversibly map roughly each square meter of the globe onto a 3-tuple of words using a simplified symmetric encryption method called [Feistel cipher](https://en.wikipedia.org/wiki/Feistel_cipher).

It seems inspired by the existing proprietary geocoding service [What3Words](https://wiki.openstreetmap.org/wiki/What3words) but uses a completely different method and list of words.

## Installation

In your Flutter/Dart `pubspec.yaml` file include

```yaml
dependencies:
    map3terms:
        git:
            url: https://github.com/randogoth/map3terms.git
```

then run

```
dart pub update
```

## Usage

```dart
import 'package:map3terms/map3terms.dart';

// coordinate to wfw
final List<double> coord = [51.50844113, -0.116708278];
final words = coordToWords(coord);
print(words); // demagogue.shuts.troll

// wfw to coordinate
final coords = wordsToCoord(words);
print(coords); // [51.5084, -0.1167]
```

---

## Original README

Check it out [here](https://pballett.github.io/whatfreewords/).

To do this we needed three things:
1. A function which maps metre-accurate (latitude, longitude) pairs into three 5-digit integers below 40k.
2. An ordered list of 40k words which acts as a bijection between integers and words.
3. A scrambling function which can be called in the first function to ensure nearby (latitude,longitude) pairs are mapped to very different integers

Note that all of these functions must be invertible for the mapping to be reversible.  

The scrambling function implemented here is inspired by format preserving encryption: it maps a sequence of 14 digits to another by passing it through a [Feistel network](https://en.wikipedia.org/wiki/Feistel_cipher). There is no need for this encryption to be secure, so the implementation has been simplifed. The point is just to map 14-digits to 14-digits, to exhibit sensitive dependence on the input and to be reversible. 
