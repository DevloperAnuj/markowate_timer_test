import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../logics/counterListPod/counterPodList.dart';
import 'counterTileView.dart';

class CounterListWidget extends ConsumerWidget {
  const CounterListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final myCountersList = ref.watch(counterListProvider).myCounterList;

    return Expanded(
      flex: 8,
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: myCountersList.length,
          itemBuilder: (context, index) {
            final item = myCountersList[index];
            return CounterTileView(counterTiming: item.counter, index: item.id);
          },
        ),
      ),
    );
  }
}
