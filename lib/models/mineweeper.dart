import 'dart:math';

import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/mineweeper.dart';
import 'package:minesweeper/models/position.dart';

enum GameState{
  started,
  lost,
  won
}
class Minesweeper{
  late List<Position> minePositions;
  late List<Cell> cells;
  int count;
  int mineCount;
  int openCellCount=0;
  GameState state=GameState.started;

  Minesweeper([this.count=100,this.mineCount=10]){
    minePositions=generateMinePositions(mineCount);
    cells=createCells(count);
  }


  /*todo 2 step 2: Create a function to generate the mine positions*/
  List<Position> generateMinePositions(int count, {int maxX=10, int maxY=10})
  {

    List<Position> minePositions=[];

    for(int i=0;i<count;i++)
    {
      int x=Random().nextInt(maxX);
      int y=Random().nextInt(maxY);

      Position thisPosition=Position(x, y);

      /*Create a new one if this already exists*/
      while(minePositions.contains(thisPosition))
      {
        x=Random().nextInt(maxX);
        y=Random().nextInt(maxY);
        thisPosition.x=x;
        thisPosition.y=y;
      }


      minePositions.add(thisPosition);
    }

    return minePositions;
  }

  /*todo 5 step 5: Create a function to create the individual cell elements*/
  List<Cell> createCells(int count, {int rowLength = 10}){
    List<Cell> cells=[];

    int rowNumber=0;
    int columnNumber=0;
    for(int i=0;i<count;i++)
    {
      rowNumber=(i/rowLength).toInt();
      columnNumber=i%rowLength;

      Position position=Position(rowNumber, columnNumber,i);
      Cell cell=Cell(i,position);

      if(minePositions.contains(position))
      {
        cell.hasMine=true;
      }
      cell.adjacentMineCount=minesAdjacentToThisCell(cell);
      cells.add(cell);
    }
    return cells;
  }

  int minesAdjacentToThisCell(Cell cell) {
    int minesAdjacentToThisCell=0;
    cell.adjacentCells.forEach((element) {
      if(minePositions.contains(element))
      {
        minesAdjacentToThisCell++;
      }
    });
    return minesAdjacentToThisCell;
  }

  attemptToReveal(Cell cell)
  {
    if(cell.hasMine)
      {
        //Lost
        state=GameState.lost;
      }
    else
      {
        reveal(cell);
      }
  }

  reveal(Cell cell)
  {
    if(cell.revealed || cell.hasMine)
      {}
    else
      {
        cell.revealed=true;
        openCellCount++;

        if(cell.adjacentMineCount>0)
          {}
        else {
        for (var position in cell.adjacentCells) {
          Cell thisCell =
              cells.firstWhere((element) => element.position == position);
          reveal(thisCell);
        }
      }
    }

    if(openCellCount==(count-mineCount))
      {
        print('++++++GAME WON++++++');
        state=GameState.won;
      }
  }
  /*reveal(Cell cell)
  {
    openCellCount++;
    cell.revealed=true;
    for (var position in cell.adjacentCells) {
      Cell thisCell=cells.firstWhere((element) => element.position==position);
      if(!thisCell.hasMine){

        if(thisCell.adjacentMineCount==0 && !thisCell.revealed)
          {
            reveal(thisCell);
          }
        else
          {
            thisCell.revealed = true;
            openCellCount++;
          }
      }
    }

    print('open cells:$openCellCount');
    if(openCellCount==(count-mineCount))
      {
        print('++++++GAME WON++++++');
      }
  }*/

}