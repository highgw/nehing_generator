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

  print('\n=== ExceptMode.word (단어 단위 제외) ===');
  // 생성된 단어 전체가 '가나'와 같으면 재생성
  print(Nehing.generate(exceptMode: ExceptMode.word, exceptWord: '가나'));
  print(Nehing.generate(
      length: 4, exceptMode: ExceptMode.word, exceptWord: '가나다라'));

  print('\n=== ExceptMode.char (글자 단위 제외) ===');
  // 생성된 음절이 '가', '나' 중 하나라도 포함되면 해당 음절 재생성
  print(Nehing.generate(exceptMode: ExceptMode.char, exceptWord: '가나'));
  print(Nehing.generate(
      length: 4, exceptMode: ExceptMode.char, exceptWord: '가나다라'));

  print('\n=== maxAttempts (최대 재시도 횟수) ===');
  try {
    // maxAttempts를 0으로 설정해 의도적으로 StateError 발생
    print(Nehing.generate(
      exceptMode: ExceptMode.word,
      exceptWord: '가나',
      maxAttempts: 0,
    ));
  } on StateError catch (e) {
    print('StateError 발생: $e');
  }

  print('\n=== 비한글 exceptWord 입력 ===');
  try {
    // 한글이 아닌 문자는 ArgumentError 발생
    print(Nehing.generate(
      exceptMode: ExceptMode.word,
      exceptWord: 'abc',
    ));
  } on ArgumentError catch (e) {
    print('ArgumentError 발생: $e');
  }
}
