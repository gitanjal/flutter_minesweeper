import 'package:flutter/material.dart';
import 'package:minesweeper/minesweeper.dart';
import 'package:minesweeper/models/mineweeper.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  initState(){
    super.initState();

    //   minePositions=generateMinePositions(10, 99);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MinesweeperBoard(Minesweeper()),
    );
  }

  /*todo 1 Step 1: Create a function to create the board widget/or create a board widget*/
 /* Widget buildBoard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: 100,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
          itemBuilder: (context,index) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 20,
                width: 20,
                color: Colors.black12,
                child: Text('${index}'),
              ),
            );
          }),
    );
  }*/





}
