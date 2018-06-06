/* 
ICS4U
2018/06/06 v1
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
    super(xPos+20, yPos+20, 5, 5);
    if (lastPress == 'u') {
      setPos(xPos+38, yPos);
    } else if (lastPress == 'd') {
      setPos(xPos+10, yPos);
    } else if (lastPress == 'r') {
      setPos(xPos, yPos+38);
    } else if (lastPress == 'l') {
      setPos(xPos, yPos+10);
    }
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
    fill(200);
    noStroke();
    if (inBounds(getX(), getBottom())) { // Checking to see if the bullet is in Bounds
      rect(getX(), getBottom(), getWidth(), getHeight());
    }
  }

}
