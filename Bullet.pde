/* 
ICS4U
2018/06/15 v1
Game Summative
Bullet class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Bullet extends Rectangle {
  private char lastKey;
  // Default constructor for the Bullet
  Bullet() {
    super();
    lastKey = ' ';
  }
  
  // Constructor for the Bullet class, sets up the position of the bullet
  Bullet(float xPos, float yPos, char lastPress) {
    super(xPos+ceil(gridSize/2), yPos+ceil(gridSize/2), ceil(gridSize*0.1), ceil(gridSize*0.1));
    //if (lastPress == 'u') { temporarily closed
    //  setPos(xPos+38, yPos);
    //} else if (lastPress == 'd') {
    //  setPos(xPos+10, yPos);
    //} else if (lastPress == 'r') {
    //  setPos(xPos, yPos+38);
    //} else if (lastPress == 'l') {
    //  setPos(xPos, yPos+10);
    //}
    this.lastKey = lastPress;
  }
  
  // Method for the bullet moving
  void move() {
    float v = ceil(gridSize/2); // Float value for the speed of the bullet, the speed will always be half the gridSize per frame
    // Shoots in a different direction depending on last key pressed
    if (lastKey == 'r') {
      setPos(getX()+v, getBottom());
    } else if (lastKey == 'l') {
      setPos(getX()-v, getBottom());
    } else if (lastKey == 'u') {
      setPos(getX(), getBottom()-v);
    } else if (lastKey == 'd') {
      setPos(getX(), getBottom()+v);
    }
    updatePos(); // Updating the other coordinates of the bullet.
  }
  
  // Method for showing the bullet
  void show() {
    fill(200);
    noStroke();
    if (inBounds(getX(), getBottom())) { // Checking to see if the bullet is in Bounds
      rect(getX(), getBottom(), getWidth(), getHeight());
    }
  }

}
