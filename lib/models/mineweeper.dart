import 'dart:math';

import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/models/position.dart';


class Minesweeper{
  late List<Position> minePositions;
  late List<Cell> cells;
  int count;
  int mineCount;

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

  reveal(Cell cell)
  {
    cell.revealed=true;
    for (var position in cell.adjacentCells) {
      Cell thisCell=cells[position.index];
      if(!thisCell.hasMine) {
        cells[position.index].revealed = true;
      }
    }
  }
}