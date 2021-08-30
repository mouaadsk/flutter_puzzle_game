import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:axie_scholarship/enums/puzzleLevel.dart';
import 'package:axie_scholarship/models/puzzleTileModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as Img;
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PuzzleModel {
  String imageLink, title;
  int? width, height;
  late int freeIndex;
  File? imageFile;
  List<PuzzleTileModel> puzzleTiles = [];
  bool completed;
  int numberOfTiles;
  PuzzleLevel puzzleLevel;
  Duration puzzleDuration;
  PuzzleModel(
      {required this.imageLink,
      this.puzzleDuration = const Duration(minutes: 3),
      required this.title,
      this.completed = false,
      this.numberOfTiles = 9,
      this.puzzleLevel = PuzzleLevel.Easy}) {
    freeIndex = this.numberOfTiles - 1;
    getImageFileFromAssets(path: imageLink).then((value) {
      imageFile = value;
      completeIintialization();
    });
  }

  PuzzleModel.fromUrl(
      {required this.imageLink,
      required this.title,
      this.puzzleDuration = const Duration(minutes: 3),
      String? imageName,
      this.freeIndex = 8,
      this.completed = false,
      this.numberOfTiles = 9,
      this.puzzleLevel = PuzzleLevel.Easy}) {
    print("the number of tiles is $numberOfTiles");
    freeIndex = this.numberOfTiles - 1;
    getImageFileFromUrl(url: imageLink, imageName: imageName).then((imageFile) {
      this.imageFile = imageFile;
      completeIintialization().then((value) {
        this.completed = value;
      });
    });
  }

  //! Method for getting an image file from a url, returns null if an error happened
  Future<File?> getImageFileFromUrl(
      {required String url, String? imageName}) async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String tempPath = documentsDirectory.path;
      imageName =
          imageName == null ? "image_${Random().nextInt(100)}.jpg" : imageName;
      File imageFile = File("$tempPath/$imageName");
      http.Response response = await http.get(Uri.parse(url));
      await imageFile.writeAsBytes(response.bodyBytes);
      return imageFile;
    } catch (e) {
      print("Error in getting the image using the url : ${e.toString()}");
      return null;
    }
  }

  Future<bool> completeIintialization() async {
    try {
      Completer<ui.Image> completer = Completer<ui.Image>();
      Image.file(imageFile!)
          .image
          .resolve(ImageConfiguration.empty)
          .addListener(ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }));
      ui.Image info = await completer.future;
      this.width = info.width;
      this.height = info.height;
      if (imageFile != null) {
        for (var i = 0; i < this.numberOfTiles - 1; i++) {
          puzzleTiles.add(PuzzleTileModel(
              tileImage: (await getCropByIndex(index: i))!,
              correctIndex: i,
              currentIndex: i));
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // getting a crop of the image pased on the index of the tile
  Future<File?> getCropByIndex({required int index}) async {
    try {
      if (getFileName() == "null") return Future.value(null);
      int linearNumberOfTiles = sqrt(this.numberOfTiles).floor();
      Img.Image croppedTile = Img.copyCrop(
          Img.decodeImage(imageFile!.readAsBytesSync())!,
          ((index % linearNumberOfTiles) * width! / linearNumberOfTiles)
              .floor(),
          ((index / linearNumberOfTiles).floor() *
                  (height! / linearNumberOfTiles))
              .floor(),
          (width! / linearNumberOfTiles).floor(),
          (height! / linearNumberOfTiles).floor());
      List<int> encodedJPG = Img.encodeJpg(croppedTile);
      File croppedFile = await File(
              '${(await getTemporaryDirectory()).path}/${this.getFileName()}tile$index.jpg')
          .create(recursive: true);
      croppedFile.writeAsBytes(encodedJPG);
      return croppedFile;
    } catch (e) {
      return null;
    }
  }

  Future<File> getImageFileFromAssets({required String path}) async {
    final byteData = await rootBundle.load(path);
    final file = await File('${(await getTemporaryDirectory()).path}/$path')
        .create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  String getFileName() {
    if (imageFile != null) {
      return imageFile!.path.split('/').last.split('.').first;
    }
    return "null";
  }

  bool moveTileByIndex({required PuzzleTileModel puzzleTile}) {
    try {
      if (areContiguous(index1: freeIndex, index2: puzzleTile.currentIndex)) {
        int tempIndex = freeIndex, puzzleTilePreIndex = puzzleTile.currentIndex;
        freeIndex = puzzleTile.currentIndex;
        puzzleTile.currentIndex = tempIndex;
        print(
            "The free index is $freeIndex, and index : $puzzleTilePreIndex moved to $tempIndex");
        return true;
      }
      return false;
    } catch (e) {
      print("Error in moving the tile by index : ${e.toString()}");
      return false;
    }
  }

  bool areContiguous({required int index1, required int index2}) {
    if (index1 % (sqrt(this.numberOfTiles).floor()) == 0 &&
        index2 == index1 - 1) return false;
    if (index2 % (sqrt(this.numberOfTiles).floor()) == 0 &&
        index1 == index2 - 1) return false;
    return [sqrt(this.numberOfTiles).floor(), 1]
        .contains((index1 - index2).abs());
  }

  bool isSolved() {
    for (var i = 0; i < puzzleTiles.length; i++) {
      if (puzzleTiles[i].currentIndex != puzzleTiles[i].correctIndex)
        return false;
    }
    print("The puzzle is solved");
    return true;
  }

  bool shufflePuzzle() {
    try {
      puzzleTiles.shuffle();
      for (var i = 0; i < puzzleTiles.length; i++) {
        puzzleTiles[i].currentIndex = i;
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
