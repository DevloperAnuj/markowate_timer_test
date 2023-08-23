import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markowate_timer/logics/counterListPod/counterPodList.dart';

class SingleCounterPod extends ChangeNotifier {

  final CounterListPod _counterListPod = CounterListPod();

  late int ctId;
  late int counterDigit;
  bool redZone = false;
  bool pause = false;
  late Timer _timer;

  void setValues({required int id, required int digit}) {
    ctId = id;
    counterDigit = digit;
    notifyListeners();
    log("===== Set Values Called =====");
  }

  startCounterDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counterDigit > 0) {
        counterDigit++;
        notifyListeners();
      } else {
        _counterListPod.deleteCounterItem(counterId: ctId);
        _timer.cancel();
        notifyListeners();
      }
    });
  }

  void pausePlay() {
    if (_timer.isActive) {
      _timer.cancel();
      notifyListeners();
    } else {
      startCounterDown();
    }
  }

  void disposeTimer() {
    _timer.cancel();
    notifyListeners();
  }
}

final singleCounterProvider = ChangeNotifierProvider((ref) {
  return SingleCounterPod();
});
