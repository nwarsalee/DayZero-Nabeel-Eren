/* 
ICS4U
2018/06/17 v1
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
    imageMode(CORNER);
    image(imgCrate, getX(), getBottom(), getWidth(), getHeight());
  }

}
