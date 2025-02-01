import 'dart:math';
import 'whatfreewords_cipher.dart';

Map<String, String> ilist = 
    wlist.map((key, value) => MapEntry(value, key));

String f(String L, String R) {
  int x = int.parse(L);
  int y = int.parse(R);
  List<String> block = [
    "1032547698",
    "7215839046",
    "9532817640",
    "1094365872",
    "6895730412",
    "1074389256",
    "5749208163",
    "8976543201",
    "2807694315",
    "8746293105"
  ];
  return block[y][x];
}

String F(String L, String K) {
  int x = int.parse(L);
  int k = int.parse(K);
  String temp = "${x * x * x * k * 3 + 23 * k * k * x * x * x + k * (x + k) + 3}";
  return temp.substring(4, 10);
}

String feistPass(String input, String k) {
  String L = input.substring(0, 6);
  String R = input.substring(6, 12);
  String Rout = "";
  String temp = F(R, k);
  for (int i = 0; i < 6; i++) {
    Rout += f(L[i], temp[i]);
  }
  return R + Rout;
}

String key = "248473";

String scrambler(String input) {
  for (int i = 0; i < key.length; i++) {
    input = feistPass(input, key[i]);
  }
  return input;
}

String unscrambler(String input) {
  input = input.substring(6, 12) + input.substring(0, 6);
  for (int i = 0; i < key.length; i++) {
    input = feistPass(input, key[key.length - 1 - i]);
  }
  return input.substring(6, 12) + input.substring(0, 6);
}

String coordToWords(List<double> coordinate) {
  int lat = (coordinate[0] * 10000).round() + 900000;
  int lon = (coordinate[1] * 10000).round() + 1800000;

  String latStr = lat.toString().padLeft(7, '0');
  String lonStr = lon.toString().padLeft(7, '0');

  String lat0 = latStr[0];
  String lon0 = lonStr[0];

  String latlonRest = scrambler(latStr.substring(1, 7) + lonStr.substring(1, 7));

  lat = int.parse(lat0 + latlonRest.substring(0, 6));
  lon = int.parse(lon0 + latlonRest.substring(6, 12));

  String ind1 = lat.toString().substring(0, 5);
  String ind2 = lon.toString().substring(0, 5);
  String ind3 = "0" + lat.toString().substring(5, 7) + lon.toString().substring(5, 7);

  return "${wlist[ind1]}.${wlist[ind2]}.${wlist[ind3]}";
}

List<double> wordsToCoord(String words) {
  List<String> word = words.split(".");
  String ind1 = ilist[word[0]]!;
  String ind2 = ilist[word[1]]!;
  String ind3 = ilist[word[2]]!;

  String lat = ind1 + ind3.substring(1, 3);
  String lon = ind2 + ind3.substring(3, 5);

  String latlonRest = lat.substring(1, 7) + lon.substring(1, 7);
  latlonRest = unscrambler(latlonRest);

  lat = lat[0] + latlonRest.substring(0, 6);
  lon = lon[0] + latlonRest.substring(6, 12);

  double latitude = (int.parse(lat) - 900000) / 10000.0;
  double longitude = (int.parse(lon) - 1800000) / 10000.0;

  return [latitude, longitude];
}

void main() {
  List<double> coordinate = [51.50844113, -0.116708278];
  String words = coordToWords(coordinate);
  print("Words: $words");
  
  List<double> backToCoord = wordsToCoord(words);
  print("Coordinates: ${backToCoord[0]}, ${backToCoord[1]}");
}
