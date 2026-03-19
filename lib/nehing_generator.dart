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

/// Modes for handling exceptions when generating text.
enum ExceptMode {
  /// 글자 단위로 처리
  char,

  /// 단어 단위로 처리(연속 문자열)
  word,
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

  /// 한글 범위 체크 (0xAC00 ~ 0xD7A3)
  static bool _isHangul(String s) {
    return s.runes.every((c) => c >= 0xAC00 && c <= 0xD7A3);
  }

  /// Generates a random Korean text string.
  ///
  /// The returned string consists of randomly combined Hangul syllables.
  ///
  /// - [length] specifies how many syllables will be generated.
  /// - If [finalConsonant] is set to false, generated syllables
  ///   will not include final consonants (받침).
  /// - [exceptMode] determines how [exceptWord] is applied during generation.
  ///   - [ExceptMode.word]: regenerates the entire result if it matches [exceptWord].
  ///   - [ExceptMode.char]: regenerates any syllable found in [exceptWord].
  /// - [exceptWord] specifies the Korean string to exclude. Must contain only
  ///   Hangul syllables. Throws [ArgumentError] if non-Hangul characters are given.
  /// - [maxAttempts] sets the maximum number of retries before throwing
  ///   a [StateError]. Defaults to 100.
  ///
  /// Throws:
  /// - [ArgumentError] if [exceptWord] contains non-Hangul characters.
  /// - [StateError] if generation fails after [maxAttempts] attempts.
  ///
  /// Example:
  /// ```dart
  /// Nehing.generate(length: 4);
  /// Nehing.generate(length: 3, finalConsonant: false);
  /// Nehing.generate(exceptMode: ExceptMode.word, exceptWord: '가나');
  /// Nehing.generate(exceptMode: ExceptMode.char, exceptWord: '가나', maxAttempts: 50);
  /// ```
  static String generate({
    int length = 2,
    bool finalConsonant = true,
    ExceptMode? exceptMode,
    String? exceptWord,
    int maxAttempts = 100,
  }) {
    // exceptWord 유효성 검사
    if (exceptWord != null && exceptWord.isNotEmpty && !_isHangul(exceptWord)) {
      throw ArgumentError(
        'exceptWord는 한글만 허용됩니다. 입력값: "$exceptWord"',
      );
    }

    if (exceptMode == null || exceptWord == null) {
      return List.generate(
        length,
        (_) => _randomSyllable(finalConsonant),
      ).join();
    }

    if (exceptMode == ExceptMode.word) {
      int attempts = 0;
      String result;
      do {
        if (attempts++ >= maxAttempts) {
          throw StateError(
            'generate()가 $maxAttempts회 시도 후에도 exceptWord("$exceptWord")와 '
            '다른 단어를 생성하지 못했습니다.',
          );
        }
        result = List.generate(
          length,
          (_) => _randomSyllable(finalConsonant),
        ).join();
      } while (result == exceptWord);
      return result;
    }

    // ExceptMode.char
    final exceptChars = exceptWord.split('').toSet();

    // 생성 가능한 음절이 하나도 없는 경우 사전 검사
    // (exceptChars가 전체 경우의 수를 덮으면 무한루프 방지)
    return List.generate(length, (_) {
      int attempts = 0;
      String syllable;
      do {
        if (attempts++ >= maxAttempts) {
          throw StateError(
            '음절 생성이 $maxAttempts회 시도 후 실패했습니다. '
            'exceptWord("$exceptWord")의 글자가 너무 많아 생성 가능한 음절이 부족할 수 있습니다.',
          );
        }
        syllable = _randomSyllable(finalConsonant);
      } while (exceptChars.contains(syllable));
      return syllable;
    }).join();
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
