/* 
ICS4U
2018/05/30 v1
Game Summative
Crate class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Crate extends Rectangle {
  
  // Default constructor
  Crate() {
    super();
  }
  
  // Constructor to set the position
  Crate(float x, float y) {
    super(x, y);
  }
  
  // Show method to show the crate object
  void show() {
    fill(124, 77, 1);
    rect(getX(), getBottom(), getWidth(), getHeight()); // Shows player as a rectangle on screen.
  }




}