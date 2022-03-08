import 'package:test/test.dart';
import 'package:basic/counter.dart';

void main() {
  group('Counter クラスに関するテスト',() {
    test('value がインクリメントされていること', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value,1);
    });
    test('value がデクリメントされていること', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value,-1);
    });
  });

}