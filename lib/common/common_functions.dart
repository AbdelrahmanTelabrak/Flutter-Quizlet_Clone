import 'dart:math';

String generateUniqueId() {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      8, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ),
  );
}