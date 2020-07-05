
/* The Algorithm and the code both are written by:
*  Muhammed Abdelhamid.
*  started coding in 28-6-2020.
*  finished in 30-6-2020.
*  inorder to understand this algorithm it is a mandatory you have a look at the readme.txt
*  readme.txt exists at the root directory but you can find it down here anyway.
*  */



import 'board.dart';
import 'controller.dart';

void main() {

  Controller controller = new Controller();

  // complexity of this algorithm is O[3*9]
  // this algorithm is pretty much fast
  // you must provide at least one element of the board inorder for the program to operate properly

  Square square = new Square([0,0,0,0,0,0,0,1,0]);
  controller.startNewPuzzle(square ,0);

  Square square1 = new Square([12,17,10,11,0,0,0,0,0]);
  controller.startNewPuzzle(square1 ,1);

  Square square2 = new Square([0,7,16,15,0,0,0,0,11]);
  controller.startNewPuzzle(square2 ,2);

  Square square3 = new Square([0,0,0,31,0,15,0,41,0]);
  controller.startNewPuzzle(square3 ,3);

  Square square4 = new Square([0,0,0,0,0,18,0,28,0]);
  controller.startNewPuzzle(square4 ,4);


}



// a copy from the readme.txt just in case

//this file contains illustration of the Algorithm i Made to solve this puzzle
//
//comparing all given cases of missing fields magic-square i found that :
//
//* all Squares follow a particular formula (take a look at Algorithm Formula.jpg)
//* the square may need to be rotated by 90, 180 or 270 degrees to match the formula given
//* the Formula state that the 9 numbers are divided to 3 levels (3 numbers per level)
//* first level is the star level and it's the highest (largest 3 numbers)
//* star numbers are located in (Descending ordered)  => (1,6,5)
//* second level is the triangle level and it's the middle (middle 3 numbers)
//* triangle numbers are located in (Descending ordered)  => (8,4,0)
//* third level is the circle level and it's the lowest (lowest 3 numbers)
//* circle numbers are located in (Descending ordered)  => (3,2,7)
//* the board in Descending order will be elements at : (1,6,5,8,4,0,3,2,7)
//* there is what we can call constant C
//* you can get the value of C from any 2 numbers from same level
//* if there ain't any then C will be 1 by default
//
//* O1 + C = O2
//* O2 + C = O3
//
//* ▲1 + C = ▲2
//* ▲2 + C = ▲3
//
//* ✩1 + C = ✩2
//* ✩2 + C = ✩3
//
//* with all this in mind you can get any element of the board
//_____________________________________________________________________
//
//-- Exception cases :
//
//- if we have a completely missing type or even two types (means we don't have any elements of this type):
//
//- case 1 missing type :
//* we get the value of any number in this level from another any two numbers (from same order but different level)
//* for example if we need to find O level we get value of O2 like the following:
//* O2 = ▲2 - (✩2 - ▲2)
//* O1 = O2 - C
//* O3 = O2 + C
//
//- case 2 missing types :
//* we assume the starting value of the lower type and get the value for rest 2 numbers by adding C each time
//* then we do the instructions for 1 missing type
//
//****** NOW WE HAVE OUR SOLVED BOARD EVEN WITHOUT THE NEED TO SUM THE ELEMENTS ******
//___________________________________________________________________________________________________________________
//
//
//
//
//







