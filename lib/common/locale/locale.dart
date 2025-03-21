import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale.g.dart';

@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale build() {
    return const Locale('ko', '');
  }

  void setLocale(EnumLocale locale) {
    state = Locale(locale.code, '');
  }
}

enum EnumLocale {
  ko,
  en;
  String get code {
    switch (this) {
      case EnumLocale.ko:
        return 'ko';
      case EnumLocale.en:
        return 'en';
    }
  }
}