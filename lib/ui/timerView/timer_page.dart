import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/counterListWidget.dart';
import 'components/counterTimerInputWidget.dart';

class TimerPage extends StatelessWidget {

  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TimerView();
  }
}

class TimerView extends ConsumerWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              TimerInputWidget(),
              CounterListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

