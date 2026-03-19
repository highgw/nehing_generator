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

  group('[exceptWord 유효성 검사 테스트]:', () {
    test('exceptWord에 영문자가 들어오면 ArgumentError가 발생한다', () {
      expect(
        () => Nehing.generate(
          exceptMode: ExceptMode.word,
          exceptWord: 'abc',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('exceptWord에 숫자가 들어오면 ArgumentError가 발생한다', () {
      expect(
        () => Nehing.generate(
          exceptMode: ExceptMode.word,
          exceptWord: '123',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('exceptWord에 특수문자가 들어오면 ArgumentError가 발생한다', () {
      expect(
        () => Nehing.generate(
          exceptMode: ExceptMode.char,
          exceptWord: '!@#',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('exceptWord에 한글+영문 혼합이면 ArgumentError가 발생한다', () {
      expect(
        () => Nehing.generate(
          exceptMode: ExceptMode.char,
          exceptWord: '가a나',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('exceptWord가 빈 문자열이면 정상 생성된다', () {
      final text = Nehing.generate(
        exceptMode: ExceptMode.word,
        exceptWord: '',
      );
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('exceptWord가 null이면 정상 생성된다', () {
      final text = Nehing.generate(exceptMode: ExceptMode.word);
      expect(text.length, 2);
      expect(isHangul(text), true);
    });
  });

  group('[ExceptMode.word 테스트]:', () {
    test('exceptMode가 null이면 exceptWord 무시하고 정상 생성된다', () {
      final text = Nehing.generate(exceptWord: '가나');
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('exceptWord가 null이면 exceptMode 무시하고 정상 생성된다', () {
      final text = Nehing.generate(exceptMode: ExceptMode.word);
      expect(text.length, 2);
      expect(isHangul(text), true);
    });

    test('생성된 단어가 exceptWord와 같지 않다', () {
      const exceptWord = '가나';
      for (var i = 0; i < 50; i++) {
        final text = Nehing.generate(
          exceptMode: ExceptMode.word,
          exceptWord: exceptWord,
        );
        expect(text, isNot(equals(exceptWord)));
        expect(isHangul(text), true);
      }
    });

    test('생성된 단어의 length가 유지된다', () {
      final text = Nehing.generate(
        length: 3,
        exceptMode: ExceptMode.word,
        exceptWord: '가나다',
      );
      expect(text.length, 3);
      expect(isHangul(text), true);
    });

    test('maxAttempts 초과 시 StateError가 발생한다', () {
      expect(
        () => Nehing.generate(
          length: 2,
          exceptMode: ExceptMode.word,
          exceptWord: '가나',
          maxAttempts: 0,
        ),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('[ExceptMode.char 테스트]:', () {
    test('생성된 음절이 exceptWord의 글자를 포함하지 않는다', () {
      const exceptWord = '가나';
      final exceptChars = exceptWord.split('').toSet();

      for (var i = 0; i < 50; i++) {
        final text = Nehing.generate(
          exceptMode: ExceptMode.char,
          exceptWord: exceptWord,
        );
        for (final char in text.split('')) {
          expect(exceptChars.contains(char), false);
        }
        expect(isHangul(text), true);
      }
    });

    test('char 모드에서 length가 유지된다', () {
      final text = Nehing.generate(
        length: 4,
        exceptMode: ExceptMode.char,
        exceptWord: '가',
      );
      expect(text.length, 4);
      expect(isHangul(text), true);
    });

    test('char 모드에서 maxAttempts 초과 시 StateError가 발생한다', () {
      expect(
        () => Nehing.generate(
          exceptMode: ExceptMode.char,
          exceptWord: '가나',
          maxAttempts: 0,
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('char 모드에서 받침 비활성화 시에도 정상 동작한다', () {
      const exceptWord = '가나';
      final exceptChars = exceptWord.split('').toSet();

      final text = Nehing.generate(
        finalConsonant: false,
        exceptMode: ExceptMode.char,
        exceptWord: exceptWord,
      );
      for (final char in text.split('')) {
        expect(exceptChars.contains(char), false);
      }
      expect(isHangul(text), true);
    });
  });
}
