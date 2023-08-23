

class CounterModel {

  final int counter;
  final int id;
  late bool pause;

  CounterModel({
    required this.counter,
    required this.id,
    this.pause = false,
  });
}
