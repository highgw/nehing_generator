/// A Dart library for generating meaningless but funny random Korean text
/// (commonly known as 'Nehing').
///
/// This package is intended for dummy data, testing, games, and fun.
/// It does not generate meaningful Korean sentences.
library nehing_generator;

import 'dart:math';

/// Emotion types for generating emotion-based sounds.
enum EmotionType {
  /// Happy/excited emotions (하하, 호호, 히히)
  happy,

  /// Sad/crying emotions (흑흑, 훌쩍, 엉엉)
  sad,

  /// Angry emotions (크악, 으악, 으르렁)
  angry,

  /// Surprised emotions (헉, 엥, 오잉)
  surprised,

  /// Laughing emotions (ㅋㅋ, ㅎㅎ, 키득)
  laughing,
}

/// Nehing generator class.
class Nehing {
  static final _random = Random();

  static const _chosung = [
    'ㄱ',
    'ㄴ',
    'ㄷ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅅ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];

  static const _jungsung = ['ㅏ', 'ㅑ', 'ㅓ', 'ㅕ', 'ㅗ', 'ㅛ', 'ㅜ', 'ㅠ', 'ㅡ', 'ㅣ'];

  static const _jongsung = [
    '',
    'ㄱ',
    'ㄴ',
    'ㄷ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅅ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];

  /// emotion presets for generating emotion-based sounds
  static const Map<EmotionType, Map<String, List<String>>> _emotionPresets = {
    EmotionType.happy: {
      'cho': ['ㅎ', 'ㅋ', 'ㅎ', 'ㅎ'], // ㅎ
      'jung': ['ㅏ', 'ㅗ', 'ㅣ', 'ㅏ'],
      'jong': ['', '', 'ㅎ', ''],
    },
    EmotionType.sad: {
      'cho': ['ㅎ', 'ㅇ', 'ㅁ'],
      'jung': ['ㅜ', 'ㅠ', 'ㅓ', 'ㅡ'],
      'jong': ['ㄱ', 'ㄴ', 'ㅁ', 'ㄹ'],
    },
    EmotionType.angry: {
      'cho': ['ㄱ', 'ㅋ', 'ㄱ', 'ㅋ'], // ㄱ, ㅋ
      'jung': ['ㅏ', 'ㅓ', 'ㅡ', 'ㅜ'],
      'jong': ['ㄱ', 'ㄹ', 'ㄱ', ''],
    },
    EmotionType.surprised: {
      'cho': ['ㅎ', 'ㅇ', 'ㅇ', 'ㅇ'], // ㅇ
      'jung': ['ㅓ', 'ㅗ', 'ㅏ', 'ㅓ'],
      'jong': ['', 'ㄱ', 'ㅇ', ''],
    },
    EmotionType.laughing: {
      'cho': ['ㅋ', 'ㅎ', 'ㄱ', 'ㅋ'], // ㅋ
      'jung': ['ㅡ', 'ㅣ', 'ㅓ', 'ㅡ'],
      'jong': ['', '', 'ㄱ', ''],
    },
  };

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

  /// Generates a random Korean text string based on emotion type.
  ///
  /// Example:
  /// ```dart
  /// Nehing.generateEmotion(EmotionType.happy);  // "하하" or "호호"
  /// Nehing.generateEmotion(EmotionType.sad);    // "흑흑" or "엉엉"
  /// ```
  static String generateEmotion(
    EmotionType emotion, {
    int length = 2,
  }) {
    return _generateFromPreset(_emotionPresets[emotion]!, length);
  }

  /// Generates a syllable from a preset.
  static String _generateFromPreset(
    Map<String, List<String>> preset,
    int length,
  ) {
    final result = <String>[];

    for (int i = 0; i < length; i++) {
      final cho = preset['cho']![_random.nextInt(preset['cho']!.length)];
      final jung = preset['jung']![_random.nextInt(preset['jung']!.length)];
      final jong = preset['jong']![_random.nextInt(preset['jong']!.length)];

      result.add(_buildSyllable(cho, jung, jong));
    }

    return result.join();
  }

  /// Generates a single random Hangul syllable.
  ///
  /// This method randomly selects initial, medial, and optional
  /// final consonants and combines them into a valid Hangul
  /// Unicode syllable.
  static String _randomSyllable(bool finalConsonant) {
    final cho = _chosung[_random.nextInt(_chosung.length)];
    final jung = _jungsung[_random.nextInt(_jungsung.length)];
    final jong =
        finalConsonant ? _jongsung[_random.nextInt(_jongsung.length)] : '';

    return _buildSyllable(cho, jung, jong);
  }

  /// Builds a Hangul syllable from components.
  static String _buildSyllable(String cho, String jung, String jong) {
    final code = 0xAC00 +
        (_chosung.indexOf(cho) * 21 * 28) +
        (_jungsung.indexOf(jung) * 28) +
        _jongsung.indexOf(jong);

    return String.fromCharCode(code);
  }
}
