import 'dart:math' as math;

class Random {
  int angleWithin(int min, int max) {
    return min + math.Random().nextInt(max - min);
  }

  int color() {
    List<int> pastelColors = [
      0xffC54B6C,
      0xff26474E,
      0xff938F43,
      0xff874741,
      0xff40383E,
      0xff46302B,
    ];

    return pastelColors[math.Random().nextInt(5)];
  }
}
