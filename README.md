# nehing_generator

[![pub package](https://img.shields.io/pub/v/nehing_generator.svg)](https://pub.dev/packages/nehing_generator)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

🎲 **의미 없는 랜덤 한글 문자열, 일명 ‘녜힁’을 생성하는 Dart 패키지입니다.**

닉네임, 더미 텍스트, 테스트 데이터,  
혹은 그냥 웃고 싶을 때 쓰면 좋을 것 같아요.

🎲 **A Dart package that generates meaningless but funny random Korean text,  
commonly known as “Nehing”.**

This package does **not** try to generate meaningful Korean words or sentences.  
Instead, it creates random Hangul syllables that are perfect for:

## Example Output

- 녜힁
- 꺄릉
- 멍텅
- 힣힣

## Usage

```dart
import 'package:nehing_generator/nehing_generator.dart';

void main() {
  print(Nehing.generate());
  print(Nehing.generate(length: 4));
  print(Nehing.generate(finalConsonant: false));
}
```

## Options

- `length` : 생성할 음절 개수 (기본값: 2)
- `finalConsonant` : 받침 포함 여부
