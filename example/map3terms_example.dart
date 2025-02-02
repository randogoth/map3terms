import 'package:map3terms/map3terms.dart';

void main() {
  List<double> coordinate = [51.50844113, -0.116708278];
  
  String words = await coordToWords(coordinate);
  print("Words: $words");
  
  List<double> backToCoord = await wordsToCoord(words);
  print("Coordinates: ${backToCoord[0]}, ${backToCoord[1]}");
}
