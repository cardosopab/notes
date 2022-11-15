import 'dart:math' as math;

class Aleatorio {
/// Creando angulo aleatorio, para la nota
  int anguloAleatorioDentroDe(int min, int max) {
    return min + math.Random().nextInt(max - min);
  }

/// Creando color aleatorio, para la nota
  int colorAleatorio() {
    List<int> coloresPastelesOscuros = [
      0xffC54B6C,
      0xff26474E,
      0xff938F43,
      0xff874741,
      0xff40383E,
      0xff46302B,
    ];

    return coloresPastelesOscuros[math.Random().nextInt(5)];
  }
}
