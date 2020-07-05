class Square {

  var _board ;

  Square(this._board);

  get board => _board ;

  //this function will determine if the board needs to be rotated or not
  bool isMatchingFormula(){
    for (int i=0 ; i<9 ;i++){
      if (_board[i] > 0){
        var indices = getIndicesOfSmallerNumbersInBoard(i);
        if(indices != -1){
          for (int index in indices){
            if (_board[i] < _board[index])  // if number is smaller than any of all numbers at indices
              return false ;
          }
        }
      }
    }
    return true;
  }

  // this function will rotate the board 90 degrees
  void rotateBoard(){
    var temp = [] ;
    temp.add(_board[6]);
    temp.add(_board[3]);
    temp.add(_board[0]);
    temp.add(_board[7]);
    temp.add(_board[4]);
    temp.add(_board[1]);
    temp.add(_board[8]);
    temp.add(_board[5]);
    temp.add(_board[2]);
    _board = temp ;
  }

  // according to the Formula
  // this function will determine indices of numbers that's supposed to be smaller than
  // the number at index to check if we need to rotate the board or not
  getIndicesOfSmallerNumbersInBoard(int index){

    switch (index){
      case 0 : // smallest number of middle level => there are 3 numbers smaller
        return [2,3,7];
      case 1 : // largest number of largest level => there is 8 numbers smaller
        return [0,2,3,4,5,6,7,8];
      case 2 : // middle number of smallest level => there is 1 number smaller
        return [7];
      case 3 : // largest number of smallest level => there are 2 numbers smaller
        return [2,7];
      case 4 : // middle number of middle level => there are 4 numbers larger
        return [0,2,3,7];
      case 5 : // smallest number of largest level => there are 6 numbers smaller
        return [0,2,3,4,7,8];
      case 6 : // middle number of largest level => there is 7 numbers smaller
        return [0,2,3,4,5,7,8];
      case 7 : // smallest number of smallest level => there is no smaller number
        return -1;
      case 8 : // largest number of middle level => there are 5 numbers smaller
        return [0,2,3,4,7];
    }
  }

  addElement(int number , int index){
    _board[index] = number ;
  }

}