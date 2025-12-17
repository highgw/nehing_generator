library nehing_generator;

import 'dart:math';

class Nehing {
  static final _random = Random();

  static const _chosung = [
    'ㄱ','ㄴ','ㄷ','ㄹ','ㅁ','ㅂ','ㅅ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
  ];

  static const _jungsung = [
    'ㅏ','ㅑ','ㅓ','ㅕ','ㅗ','ㅛ','ㅜ','ㅠ','ㅡ','ㅣ'
  ];

  static const _jongsung = [
    '', 'ㄱ','ㄴ','ㄷ','ㄹ','ㅁ','ㅂ','ㅅ','ㅇ','ㅈ','ㅊ','ㅋ','ㅌ','ㅍ','ㅎ'
  ];

  static String generate({
    int length = 2,
    bool finalConsonant = true,
  }) {
    return List.generate(
      length,
          (_) => _randomSyllable(finalConsonant),
    ).join();
  }

  static String _randomSyllable(bool finalConsonant) {
    final cho = _chosung[_random.nextInt(_chosung.length)];
    final jung = _jungsung[_random.nextInt(_jungsung.length)];
    final jong = finalConsonant
        ? _jongsung[_random.nextInt(_jongsung.length)]
        : '';

    final code = 0xAC00 +
        (_chosung.indexOf(cho) * 21 * 28) +
        (_jungsung.indexOf(jung) * 28) +
        _jongsung.indexOf(jong);

    return String.fromCharCode(code);
  }
}
