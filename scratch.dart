void main() {
  taskExecuter();
}

void taskExecuter() async {
  task1();
  String text = await task2();
  print(await task2());
  task3(text: text);
}

void task1() {
  print('TASK 1ST WAS SEEN..!');
}

Future<String> task2() async {
  String task2;
  Duration threeSeconds = Duration(seconds: 10);
  await Future.delayed(threeSeconds, () {
    task2 = "TASK 2";
    print("$task2 WAS SEEN!");
  });
  return task2;
}

void task3({String text}) {
  print("TASK3 With $text was seen!!");
}
