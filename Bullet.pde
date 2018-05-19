/* 
ICS4U
2018/05/19
Game Summative
Player class
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
    super(xPos+25, yPos+25, 10, 10);
    this.lastKey = lastPress;
  }
  
  // Method for the bullet moving
  void move() {
    // Shoots in a different direction depending on last key pressed
    if (lastKey == 'r') {
      setPos(getX()+10, getBottom());
    } else if (lastKey == 'l') {
      setPos(getX()-10, getBottom());
    } else if (lastKey == 'u') {
      setPos(getX(), getBottom()-10);
    } else if (lastKey == 'd') {
      setPos(getX(), getBottom()+10);
    }
    updatePos(); // Updating the other coordinates of the bullet.
  }
  
  // Method for showing the bullet
  void show() {
    if (inBounds(getX(), getBottom())) { // Checking to see if the bullet is in Bounds
      rect(getX(), getBottom(), getWidth(), getHeight());
    }
  }

}