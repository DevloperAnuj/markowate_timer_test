import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../logics/counterListPod/counterPodList.dart';

class TimerInputWidget extends ConsumerWidget {
  const TimerInputWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    TextEditingController minController = TextEditingController();
    TextEditingController secController = TextEditingController();

    void clearFields() {
      minController.clear();
      secController.clear();
    }

    void addingCounterInList({required int overSec}) {
      if (ref.watch(counterListProvider).myCounterList.length <= 10) {
        if (!overSec.isNegative) {
          ref.read(counterListProvider).addCounterItem(counterVal: overSec);
          clearFields();
        }
      } else {
        showDialog(
          context: context,
          builder: (_) {
            return const AlertDialog(
              title: Text(
                "List Is Full. You Cant Add More Than 10 Tasks At Time",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              icon: Icon(
                Icons.format_overline,
                size: 50,
                color: Colors.orange,
              ),
            );
          },
        );
      }
    }

    parseValue() {
      if (secController.text.isEmpty || minController.text.isEmpty) {
        return;
      } else {
        final min = int.parse(minController.text.trim());
        final sec = int.parse(secController.text.trim());
        if (min >= 59 || sec >= 60 || sec.isNegative || min.isNegative) {
          showDialog(
            context: context,
            builder: (_) {
              return const AlertDialog(
                title: Text(
                  "You can't pass Seconds less than 0 and More than 60 also cant Pass Minutes More Than 59 and less than 0 !",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                icon: Icon(
                  Icons.info,
                  size: 50,
                  color: Colors.orange,
                ),
              );
            },
          );
        } else {
          final overallSec = (min * 60) + sec;
          addingCounterInList(overSec: overallSec);
        }
      }
    }

    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: minController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Minute",
                      style: TextStyle(color: Colors.black),
                    ),
                    hintText: "between 1 to 59",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: secController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Seconds",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    hintText: "between 1 to 60",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.black),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 22,
                  child: IconButton.outlined(
                    onPressed: () {
                      parseValue();
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
