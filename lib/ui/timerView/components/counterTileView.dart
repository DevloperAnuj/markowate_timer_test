import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markowate_timer/logics/counterListPod/counterPodList.dart';
import 'package:pausable_timer/pausable_timer.dart';

class CounterTileView extends ConsumerStatefulWidget {
  final int counterTiming;
  final int index;

  const CounterTileView({
    super.key,
    required this.counterTiming,
    required this.index,
  });

  @override
  ConsumerState<CounterTileView> createState() => _CounterTileViewState();
}

class _CounterTileViewState extends ConsumerState<CounterTileView> {
  late Timer _timer;
  late PausableTimer myTimer;
  late int myCounter = 0;
  late bool pause = false;

  void startTimer({required bool fresh}) {
    if (fresh) {
      myCounter = widget.counterTiming;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (myCounter == 0) {
          ref
              .read(counterListProvider)
              .deleteCounterItem(counterId: widget.index);
          setState(() {});
        } else if (myCounter > 0) {
          setState(() {
            myCounter--;
          });
        }
      });
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (myCounter == 0) {
          setState(() {
            ref
                .read(counterListProvider)
                .deleteCounterItem(counterId: widget.index);
          });
        } else if (myCounter > 0) {
          setState(() {
            myCounter--;
          });
        }
      });
    }
  }

  void pausePlay() {
    if (_timer.isActive) {
      _timer.cancel();
    } else {
      startTimer(fresh: false);
    }
  }

  formatTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer(fresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        formatTime(timeInSecond: myCounter),
        style: TextStyle(
            fontSize: 35,
            color: !_timer.isActive
                ? Colors.yellow
                : myCounter > 30
                    ? Colors.green
                    : Colors.red),
      ),
      trailing: IconButton(
        onPressed: () {
          setState(() {
            pausePlay();
          });
        },
        icon: Icon(_timer.isActive ? Icons.play_circle : Icons.pause_circle),
      ),
    );
  }
}
