import 'package:flutter/material.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/mineweeper.dart';
import 'package:minesweeper/models/position.dart';

class MinesweeperBoard extends StatefulWidget {
  MinesweeperBoard(this.minesweeper, {Key? key}) : super(key: key);
  Minesweeper minesweeper;

  @override
  State<MinesweeperBoard> createState() => _MinesweeperBoardState();
}

class _MinesweeperBoardState extends State<MinesweeperBoard> {
  List<Position> pos = [];

  @override
  Widget build(BuildContext context) {
    /*todo 1 Step 1: Create a function to create the board widget/or create a board widget*/
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Minesweeper',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: 100,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (context, index) {
                    Cell thisCell = widget.minesweeper.cells[index];
                    return GestureDetector(
                      onTap: () {
                        widget.minesweeper.attemptToReveal(thisCell);
                        if (!thisCell.revealed) {}
                        pos = thisCell.adjacentCells;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Card(
                          elevation: 8,
                          child: thisCell.revealed ||
                                  widget.minesweeper.state == GameState.lost
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  color: Colors.black26,
                                  child: thisCell.hasMine
                                      ? Icon(Icons.bolt)
                                      : Text(
                                          '${thisCell.adjacentMineCount == 0 ? '' : thisCell.adjacentMineCount}'))
                              : Container(
                                  height: 20,
                                  width: 20,
                                  color: Colors.green,
/*                          child: thisCell.hasMine
                                  ? Icon(Icons.bolt)
                                  : Text(
                                  '${thisCell.adjacentMineCount == 0 ? '' : thisCell.adjacentMineCount}')*/
                                ),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              child: Column(
                children: [
                  buildStatusMessage(widget.minesweeper.state),
                  IconButton(onPressed: (){
                    widget.minesweeper=Minesweeper();
                    setState((){});
                  }, icon: Icon(Icons.restart_alt))
                ],
              ),
            )
            // Text(pos.toString())
          ],
        ),
      ),
    );
  }

  Widget buildStatusMessage(GameState state) {
    Color? color;
    String text = '';

    switch (state) {
      case GameState.lost:
        {
          text = 'Game over, you lost';
          color = Colors.red;
          break;
        }
      case GameState.won:
        {
          text = 'Game over, you won';
          color = Colors.blue;
          break;
        }
    }

    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: 30,
          shadows:[Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 10.0,
            color: Colors.grey,
          ),],
          fontWeight: FontWeight.bold),
    );
  }
}
