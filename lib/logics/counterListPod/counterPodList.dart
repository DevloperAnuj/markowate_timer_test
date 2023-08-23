import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markowate_timer/models/counterModel.dart';


class CounterListPod extends ChangeNotifier {

  final List<CounterModel> myCounterList = [];

  void addCounterItem({required int counterVal}) {
    myCounterList.add(CounterModel(
      counter: counterVal,
      id: DateTime.now().microsecondsSinceEpoch,
    ));
    notifyListeners();
  }

  void deleteCounterItem({required int counterId}) {
    myCounterList.removeWhere((element) => element.id == counterId);
    notifyListeners();
  }

}

final counterListProvider = ChangeNotifierProvider((ref) => CounterListPod());
