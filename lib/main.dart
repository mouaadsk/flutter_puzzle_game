import 'package:flutter_puzzle_game/models/puzzleModel.dart';
import 'package:flutter_puzzle_game/models/screenSize.dart';
import 'package:flutter_puzzle_game/screens/puzzleCardsPage.dart';
import 'package:flutter_puzzle_game/screens/puzzlesChoice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PuzzleModel _puzzleModel = PuzzleModel.fromUrl(
      imageLink: "https://i.ibb.co/5T39vkz/insect.jpg",
      imageName: "insect.jpg",
      numberOfTiles: 9,
      title: "insect");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ScreenSize>(
          create: (_) => ScreenSize(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        )
      ],
      child: PuzzlesChoicePage(),
    );
  }
}
