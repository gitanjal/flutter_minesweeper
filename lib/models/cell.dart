import 'dart:math' as math;

import 'package:minesweeper/models/position.dart';

/*todo 3 step 3: Create a class to represent the individual cells*/
class Cell{
  int index;
  /*int positionX;
  int positionY;*/

  bool revealed=false;
  bool hasMine=false;
  int adjacentMineCount=0;
  List<Position> adjacentCells=[];
  Position position;

  Cell(this.index,this.position){
    this.adjacentCells=findAdjacentCells();
  }

/*todo 4 step 4: Create a function to find the adjacent cells*/
  List<Position> findAdjacentCells({int rowItemsCount=10,int colItemsCount=10, int min=0, int max=99}){

    List<Position> adjacentCells=[];

    if(isValidIndex(position.x - 1, position.y - 1)) {
      adjacentCells.add(
          Position(position.x - 1, position.y - 1, index - rowItemsCount + 1));
    }
    if(isValidIndex(position.x-1, position.y)) {
      adjacentCells.add(
          Position(position.x-1, position.y , index - rowItemsCount));
    }
    if(isValidIndex(position.x-1, position.y + 1)) {
      adjacentCells.add(
          Position(position.x - 1, position.y + 1, index - rowItemsCount - 1));
    }

    if(isValidIndex(position.x, position.y-1)) {
      adjacentCells.add(Position(position.x , position.y-1, index - 1));
    }
    if(isValidIndex(position.x, position.y+1)) {
      adjacentCells.add(Position(position.x , position.y+1, index + 1));
    }


    if(isValidIndex(position.x+1, position.y-1)) {
      adjacentCells.add(
          Position(position.x + 1, position.y-1, index + rowItemsCount - 1));
    }
    if(isValidIndex(position.x+1, position.y)) {
      adjacentCells.add(
          Position(position.x+1, position.y , index + rowItemsCount));
    }
    if(isValidIndex(position.x+1, position.y+1)) {
      adjacentCells.add(
          Position(position.x + 1, position.y + 1, index + rowItemsCount + 1));
    }


    return adjacentCells;
  }

  /*Create a function to check if an index is valid one*/
  bool isValidIndex(int x,int y,[int rowLength=10,int colLength=10])
  {
    print('($x,$y)');

    bool valid=x>=0 && x<rowLength && y>=0 && y<colLength;
    if(valid)print('---Valid');
    return valid;
  }
}