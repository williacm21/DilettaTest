import 'dart:math';

extension ListExtension<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
