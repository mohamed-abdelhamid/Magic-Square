import 'board.dart';


class Controller{


  startNewPuzzle(Square square , int boardNo){
    int numRotations = get_correct_angle_of_board(square);
    solveBoard(square);
    if (numRotations > 0)
      for(int i=0 ; i< 4-numRotations ; i++){
        square.rotateBoard();
      }
    printBoard(square.board , boardNo);
  }


// this function will rotate the board until it matches the Formula
// to make it easier dealing with indices
// if it already matches it then no rotation will occur
  int get_correct_angle_of_board(Square square) {
    int turn = 0;
    while(square.isMatchingFormula() != true){
      square.rotateBoard();
      turn++ ;
      if (turn == 4) {
        print('can\'t formulate board');
        break ;
      }
    }
    return turn ;
  }

  void printBoard(var board , int boardNo){
    print('board $boardNo: ');
    for(int i=0 ; i<9 ; i+=3){
      print('${board[i]}      ${board[i+1]}      ${board[i+2]}');
    }
    print('__________________________________');
  }



//this function will search for any 2 slots from same type to get the added value
  int get_value_from_same_type(board) {

    var typeStarIndices = [5,6,1]; // indices of numbers from type star (ordered from smallest to largest)
    var typeTriangleIndices = [0,4,8];
    var typeCircleIndices = [7,2,3];
    int addedValue = 1 ;
    for(int i=0 ; i<3 ; i++){
      int x = i==2 ? 0 : i ;
      int y = i==2 ? 1 : i ;
      if(board[typeStarIndices[x]] != 0 && board[typeStarIndices[y+1]] != 0 ){
        addedValue = board[typeStarIndices[y+1]] - board[typeStarIndices[x]] ;
        addedValue = i==2 ? addedValue~/2 : addedValue ; // because difference will be 2C and we need C
        break;
      }
      if(board[typeTriangleIndices[x]] != 0 && board[typeTriangleIndices[y+1]] != 0 ){
        addedValue = board[typeTriangleIndices[y+1]] - board[typeTriangleIndices[x]] ;
        addedValue = i==2 ? addedValue~/2 : addedValue ;
        break;
      }
      if(board[typeCircleIndices[x]] != 0 && board[typeCircleIndices[y+1]] != 0 ){
        addedValue = board[typeCircleIndices[y+1]] - board[typeCircleIndices[x]] ;
        addedValue = i==2 ? addedValue~/2 : addedValue ;
        break;
      }
    }
    return addedValue;
  }


// this function will check if all given indices are empty
  bool typeIsMissing(List<int> indices , board) {
    for(int index in indices){
      if(board[index] != 0) return false;
    }
    return true;
  }


// this function will fill the board
  void fillType(Square square, List<int> indices, int addedValue ) {

    if (square.board[indices[0]] != 0){
      square.addElement(square.board[indices[0]] + addedValue, indices[1]);
      square.addElement(square.board[indices[0]] + (2*addedValue), indices[2]);
    }
    else if (square.board[indices[1]] != 0){
      square.addElement(square.board[indices[1]] - addedValue, indices[0]);
      square.addElement(square.board[indices[1]] + addedValue, indices[2]);
    }
    else if (square.board[indices[2]] != 0){
      square.addElement(square.board[indices[2]] - (2*addedValue), indices[0]);
      square.addElement(square.board[indices[2]] - addedValue, indices[1]);
    }
  }


  solveBoard(Square square){

    //int constant = getTotal(square.board);
    final addedValue = get_value_from_same_type(square.board).toInt();

    // check to see how many types are missing from the board one or two ..
    // cause at least one type must exist
    var missingTypes = [];
    if (typeIsMissing([7,2,3], square.board)){
      missingTypes.add(0); // type O is missing
    }
    if (typeIsMissing([0,4,8], square.board)){
      missingTypes.add(1); // type ▲ is missing
    }
    if (typeIsMissing([5,6,1], square.board)){
      missingTypes.add(2); // type ✩ is missing
    }

    if (missingTypes.length == 0){ // all types exist
      fillType(square ,[7,2,3], addedValue); // fill all type O slots
      fillType(square ,[0,4,8], addedValue); // fill all type ▲ slots
      fillType(square ,[5,6,1], addedValue); // fill all type ✩ slots
    }
    else if (missingTypes.length == 1){ // one type is missing

      if (missingTypes[0] == 0){ // type O is missing and other types exist
        fillType(square ,[0,4,8], addedValue); // fill all type ▲ slots
        fillType(square ,[5,6,1], addedValue); // fill all type ✩ slots
        // now we will predict type O based on the value between the ✩2 and ▲2 to get O2
        // ✩2 and ▲2 indices are 6 , 4 respectively
        // since O2 location is at index 2 of the board :
        square.addElement(square.board[4] - (square.board[6]-square.board[4]) ,  2);
        // then complete type O
        fillType(square ,[7,2,3], addedValue); // fill all type O slots
      }

      else if (missingTypes[0] == 1){ // type ▲ is missing and other types exist
        fillType(square ,[7,2,3], addedValue); // fill all type O slots
        fillType(square ,[5,6,1], addedValue); // fill all type ✩ slots
        // now we will predict type ▲ based on the value between the ✩2 and O2 to get ▲2
        // O2 and ✩2 indices are 2 , 6 respectively
        // since ▲2 location is at index 4 of the board :
        square.addElement((square.board[2]+ (square.board[6] - square.board[2])/2).toInt()  ,  4);
        // then complete type ▲
        fillType(square ,[0,4,8], addedValue); // fill all type ▲ slots
      }

      else if (missingTypes[0] == 2){ // type ✩ is missing and other types exist
        fillType(square ,[7,2,3], addedValue); // fill all type O slots
        fillType(square ,[0,4,8], addedValue); // fill all type ▲ slots

        // now we will predict type ✩ based on the value between the O2 and O2 to get ✩2
        // O2 and ▲2 indices are 2 , 4 respectively
        // since ✩2 location is at index 6 of the board :
        square.addElement(square.board[4] + (square.board[4] - square.board[2]) ,  6);
        // then complete type ✩
        fillType(square ,[5,6,1], addedValue); // fill all type ✩ slots
      }

    }
    else if (missingTypes.length == 2){ // two types are completely missing

      if(missingTypes[0] == 0 && missingTypes[1] == 1){
        // type O and type ▲ is missing
        // fill type ✩
        fillType(square ,[5,6,1], addedValue); // fill all type ✩ slots
        // we will predict O from scratch
        // and predict type ▲ based on value of ✩2 and O2 to get ▲2
        square.addElement(1, 7); // add 1 to smallest O
        square.addElement(1 + addedValue , 2); // add value to middle O
        square.addElement(1 + 2*addedValue , 3); // add value to largest O

        // now predict ▲2
        square.addElement(square.board[2] + (square.board[6] - square.board[2])/2 .toInt() ,  4);
        // then complete type ▲
        fillType(square ,[0,4,8], addedValue); // fill all type ▲ slots
      }
      else if(missingTypes[0] == 1 && missingTypes[1] == 2){
        // type ▲ and type ✩ is missing
        fillType(square ,[7,2,3], addedValue); // fill all type O slots
        // we will predict ▲ from scratch
        // and predict type ✩ based on value of ▲2 and O2 to get ✩2
        square.addElement(1 + square.board[3] , 0); // add 1 to largest O to get ▲1
        square.addElement(1 + square.board[3] + addedValue , 4); // add value to middle ▲
        square.addElement(1 + square.board[3] + 2*addedValue , 8); // add value to largest ▲

        // now predict ✩2
        square.addElement(square.board[4] + (square.board[4] - square.board[2]) ,  6);
        // then complete type ✩
        fillType(square ,[5,6,1], addedValue); // fill all type ✩ slots
      }
      else if(missingTypes[0] == 0 && missingTypes[1] == 2){
        // type O and type ✩ is missing
        fillType(square ,[0,4,8], addedValue); // fill all type ▲ slots
        // we will predict O from scratch
        // and predict type ✩ based on value of ▲2 and O2 to get ✩2
        square.addElement(1, 7); // add 1 to smallest O
        square.addElement(1 + addedValue , 2); // add value to middle O
        square.addElement(1 + 2*addedValue , 3); // add value to largest O

        // now predict ✩2
        square.addElement(square.board[4] + (square.board[4] - square.board[2]) ,  6);
        // then complete type ✩
        fillType(square ,[5,6,1], addedValue); // fill all type ✩ slots
      }

    }

  }


}