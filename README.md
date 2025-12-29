# nehing_generator

[![pub package](https://img.shields.io/pub/v/nehing_generator.svg)](https://pub.dev/packages/nehing_generator)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![CI](https://github.com/highgw/nehing_generator/actions/workflows/ci-release.yml/badge.svg)

🎲 **의미 없는 랜덤 한글 문자열, 일명 ‘녜힁’을 생성하는 Dart 패키지입니다.**

닉네임, 더미 텍스트, 테스트 데이터, 감정 표현,  
혹은 그냥 웃고 싶을 때 쓰면 좋을 것 같아요.

🎲 **A Dart package that generates meaningless but funny random Korean text,  
commonly known as “Nehing”.**

This package does **not** try to generate meaningful Korean words or sentences.  
Instead, it creates random Hangul syllables that are perfect for:
- Dummy text and placeholder content
- Test data generation
- Random nicknames
- Emotion expressions and onomatopoeia
- Fun experiments

## Example Output

### Basic Generation
- 녜힁
- 꺄릉
- 멍텅
- 힣힣

### Emotion Onomatopoeia
- 하하 (happy)
- 흑흑 (sad)
- 크악 (angry)
- 헉엉 (surprised)
- 킥킥 (laughing)

## Usage

### Basic Random Generation

```dart
import 'package:nehing_generator/nehing_generator.dart';

void main() {
  // 기본 2음절 생성
  print(Nehing.generate());  // 예: "녜힁"
  
  // 길이 지정
  print(Nehing.generate(length: 4));  // 예: "꺄릉멍텅"
  
  // 받침 제외
  print(Nehing.generate(finalConsonant: false));  // 예: "코나리"
}
```

### Emotion Onomatopoeia

```dart
import 'package:nehing_generator/nehing_generator.dart';

void main() {
  // 행복한 소리
  print(Nehing.generateEmotion(EmotionType.happy));  // 예: "하하"
  
  // 슬픈 소리
  print(Nehing.generateEmotion(EmotionType.sad));  // 예: "흑흑"
  
  // 화난 소리
  print(Nehing.generateEmotion(EmotionType.angry));  // 예: "크악"
  
  // 놀란 소리
  print(Nehing.generateEmotion(EmotionType.surprised));  // 예: "헉엉"
  
  // 웃음 소리
  print(Nehing.generateEmotion(EmotionType.laughing));  // 예: "킥킥"
  
  // 길이 조절
  print(Nehing.generateEmotion(EmotionType.laughing, length: 4));  // 예: "킥킥크킥"
}
```

## API Reference

### `Nehing.generate()`

기본 랜덤 한글 문자열을 생성합니다.

**Parameters:**
- `length` (int, default: 2) - 생성할 음절 개수
- `finalConsonant` (bool, default: true) - 받침 포함 여부

**Returns:** `String`

### `Nehing.generateEmotion()`

감정에 맞는 의성어를 생성합니다.

**Parameters:**
- `emotion` (EmotionType, required) - 감정 타입
    - `EmotionType.happy` - 행복/흥분
    - `EmotionType.sad` - 슬픔/울음
    - `EmotionType.angry` - 화남
    - `EmotionType.surprised` - 놀람
    - `EmotionType.laughing` - 웃음
- `length` (int, default: 2) - 생성할 음절 개수

**Returns:** `String`

## Links

- [pub.dev](https://pub.dev/packages/nehing_generator)
- [GitHub Repository](https://github.com/highgw/nehing_generator)
- [Issue Tracker](https://github.com/highgw/nehing_generator/issues)