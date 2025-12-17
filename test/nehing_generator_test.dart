import 'package:test/test.dart';
import 'package:nehing_generator/nehing_generator.dart';

void main() {
  bool isHangul(String s) {
    return s.runes.every((c) => c >= 0xAC00 && c <= 0xD7A3);
  }

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
}