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
    //this.adjacentCells=findAdjacentCells();
  }

}