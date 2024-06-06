import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DominantColorNotifier extends ValueNotifier<Color> {
  DominantColorNotifier() : super(Colors.blue);

  Future<void> getImagePalette (ImageProvider imageAsset) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageAsset);
    value = paletteGenerator.dominantColor!.color;
  }

  void resetPalette() {
    value = Colors.blue;
  }

}