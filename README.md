# nehing_generator

의미 없는 랜덤 한글 문자열(녜힁)을 생성하는 Dart 패키지입니다.

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
