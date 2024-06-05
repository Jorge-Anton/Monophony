import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DominantColorController extends ValueNotifier<Color> {
  DominantColorController() : super(Colors.blue);

  Future<void> getImagePalette (ImageProvider imageAsset) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageAsset);
    value = paletteGenerator.dominantColor!.color;
  }

}