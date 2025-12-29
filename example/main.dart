import 'package:nehing_generator/nehing_generator.dart';

void main() {
  print('=== 기본 생성 ===');
  print(Nehing.generate());
  print(Nehing.generate(length: 4));
  print(Nehing.generate(finalConsonant: false));

  print('\n=== 감정 의성어 ===');
  print('행복: ${Nehing.generateEmotion(EmotionType.happy)}');
  print('슬픔: ${Nehing.generateEmotion(EmotionType.sad)}');
  print('화남: ${Nehing.generateEmotion(EmotionType.angry)}');
  print('놀람: ${Nehing.generateEmotion(EmotionType.surprised)}');
  print('웃음: ${Nehing.generateEmotion(EmotionType.laughing)}');
}
