/*
ICS4U
2018/06/17 v1
Game Summative
Loot Class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Loot extends Rectangle {
  private boolean notUsed; // Boolean for whether or not the loot box has been used/triggered
  
  // Default constructor
  Loot() {
    super();
    notUsed = true;
  }
  
  // Constructor to set the position
  Loot(float x, float y) {
    super(x,y); 
    notUsed = true;
  }
  
  // Method to show the loot icon
  void show() {
    imageMode(CORNER);
    image(imgHealth, getX(), getBottom(), getWidth(), getHeight());
  }
  
  // Method to show whether or not the loot has been picked up
  boolean pickedUp(Player p) {
    if (intersect(p) && notUsed) {
      notUsed = false; // Sets not used to false, so that it doesnt trigger health again
      return true;
    } else {
      return false;
    }
  }


}
