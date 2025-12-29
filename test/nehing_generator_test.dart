import 'package:test/test.dart';
import 'package:nehing_generator/nehing_generator.dart';

void main() {
  bool isHangul(String s) {
    return s.runes.every((c) => c >= 0xAC00 && c <= 0xD7A3);
  }

  group('[기본 테스트]:', () {
    test('기본 length는 2이다', () {
      final text = Nehing.generate();
      expect(text.length, 2);
    });

    test('length 옵션이 정상 동작한다', () {
      final text = Nehing.generate(length: 4);
      expect(text.length, 4);
    });

    test('length가 0이면 빈 문자열을 반환한다', () {
      final text = Nehing.generate(length: 0);
      expect(text, '');
    });

    test('받침 비활성화 시에도 한글이 생성된다', () {
      final text = Nehing.generate(finalConsonant: false);
      expect(text.isNotEmpty, true);
    });

    test('생성된 문자열은 한글이다', () {
      final text = Nehing.generate(length: 5);
      expect(isHangul(text), true);
    });
  });

  group('[감정 의성어 테스트]:', () {
    test('행복 감정 의성어가 생성된다', () {
      final text = Nehing.generateEmotion(EmotionType.happy);
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('슬픔 감정 의성어가 생성된다', () {
      final text = Nehing.generateEmotion(EmotionType.sad);
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('화남 감정 의성어가 생성된다', () {
      final text = Nehing.generateEmotion(EmotionType.angry);
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('놀람 감정 의성어가 생성된다', () {
      final text = Nehing.generateEmotion(EmotionType.surprised);
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('웃음 감정 의성어가 생성된다', () {
      final text = Nehing.generateEmotion(EmotionType.laughing);
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('감정 의성어 length 옵션이 정상 동작한다', () {
      final text = Nehing.generateEmotion(EmotionType.happy, length: 4);
      expect(text.length, 4);
      expect(isHangul(text), true);
    });

    test('모든 감정 타입이 동작한다', () {
      for (var emotion in EmotionType.values) {
        final text = Nehing.generateEmotion(emotion);
        expect(text.isNotEmpty, true);
        expect(isHangul(text), true);
      }
    });
  });
}
