/// A Dart library for generating meaningless but funny random Korean text
/// (commonly known as 'Nehing').
///
/// This package is intended for dummy data, testing, games, and fun.
/// It does not generate meaningful Korean sentences.
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

  /// Generates a random Korean text string.
  ///
  /// The returned string consists of randomly combined Hangul syllables.
  ///
  /// - [length] specifies how many syllables will be generated.
  /// - If [finalConsonant] is set to false, generated syllables
  ///   will not include final consonants (받침).
  ///
  /// Example:
  /// ```dart
  /// Nehing.generate(length: 4);
  /// Nehing.generate(length: 3, finalConsonant: false);
  /// ```
  static String generate({
    int length = 2,
    bool finalConsonant = true,
  }) {
    return List.generate(
      length,
          (_) => _randomSyllable(finalConsonant),
    ).join();
  }

  /// Generates a single random Hangul syllable.
  ///
  /// This method randomly selects initial, medial, and optional
  /// final consonants and combines them into a valid Hangul
  /// Unicode syllable.
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
