import 'package:nehing_generator/nehing_generator.dart';

void main() {
  print(Nehing.generate());
  print(Nehing.generate(length: 4));
  print(Nehing.generate(finalConsonant: false));
}
