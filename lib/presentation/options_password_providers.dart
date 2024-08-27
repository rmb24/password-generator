import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "options_password_providers.g.dart";

@riverpod
class CounterDigits extends _$CounterDigits {
  int digits = 0;

  @override
  int build() => digits;

  void incrementDigits(int length, int capitals, int symbols) {
    if (digits + capitals + symbols + 1 > length) return;
    digits += 1;
    updateState();
  }

  void decrementDigits() {
    if (digits > 0) {
      digits -= 1;
      updateState();
    }
  }

  void updateState() {
    state = digits;
  }
}

@riverpod
class CounterCapitals extends _$CounterCapitals {
  int capitals = 0;

  @override
  int build() => capitals;

  void incrementCapitals(int length, int digits, int symbols) {
    if (capitals + digits + symbols + 1 > length) return;
    capitals += 1;
    updateState();
  }

  void decrementCapitals() {
    if (capitals > 0) {
      capitals -= 1;
      updateState();
    }
  }

  void updateState() {
    state = capitals;
  }
}

@riverpod
class CounterSymbols extends _$CounterSymbols {
  int symbols = 0;

  @override
  int build() => symbols;

  void incrementSymbols(int length, int digits, int capitals) {
    if (symbols + digits + capitals + 1 > length) return;
    symbols += 1;
    updateState();
  }

  void decrementSymbols() {
    if (symbols > 0) {
      symbols -= 1;
      updateState();
    }
  }

  void updateState() {
    state = symbols;
  }
}

@riverpod
class CounterLength extends _$CounterLength {
  int length = 8;

  @override
  int build() => length;

  void incrementLength() {
    length += 1;
    updateState();
  }

  void decrementLength() {
    if (length > 0) {
      length -= 1;
      updateState();
    }
  }

  void updateState() {
    state = length;
  }
}

String generateRandomCharacter(String chars) {
  final random = Random.secure();
  return chars[random.nextInt(chars.length)];
}

String generatePassword(int digits, int capitals, int symbols, int length) {
  const String numbers = '0123456789';
  const String capitalLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String symbolChars = '!@#\$%^&*()_+-=[]{}|;:\'",.<>?/';
  const String lowerLetters = 'abcdefghijklmnopqrstuvwxyz';

  if (digits + capitals + symbols > length) {
    int totalRequired = digits + capitals + symbols;
    double scaleFactor = length / totalRequired;
    digits = (digits * scaleFactor).floor();
    capitals = (capitals * scaleFactor).floor();
    symbols = (symbols * scaleFactor).floor();

    while (digits + capitals + symbols > length) {
      if (symbols > 0) {
        symbols--;
      } else if (capitals > 0)
        capitals--;
      else if (digits > 0) digits--;
    }
  }

  final List<String> passwordChars = [];
  for (int i = 0; i < digits; i++) {
    passwordChars.add(generateRandomCharacter(numbers));
  }
  for (int i = 0; i < capitals; i++) {
    passwordChars.add(generateRandomCharacter(capitalLetters));
  }
  for (int i = 0; i < symbols; i++) {
    passwordChars.add(generateRandomCharacter(symbolChars));
  }
  while (passwordChars.length < length) {
    passwordChars.add(generateRandomCharacter(lowerLetters));
  }

  passwordChars.shuffle(Random.secure());
  return passwordChars.join('');
}

@riverpod
class GeneratePassword extends _$GeneratePassword {
  final int digits;
  final int capitals;
  final int symbols;
  final int length;

  GeneratePassword(
      {this.digits = 0, this.capitals = 0, this.symbols = 0, this.length = 8});

  @override
  String build() {
    return generatePassword(digits, capitals, symbols, length);
  }

  void generate() {
    state = generatePassword(digits, capitals, symbols, length);
  }

  void updateValues(
      int newDigits, int newCapitals, int newSymbols, int newLength) {
    state = generatePassword(newDigits, newCapitals, newSymbols, newLength);
  }
}
