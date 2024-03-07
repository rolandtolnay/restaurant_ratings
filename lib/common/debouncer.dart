import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  Debouncer([this.duration = const Duration(milliseconds: 1000)]);

  final Duration duration;

  Timer? _timer;

  void run(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }
}
