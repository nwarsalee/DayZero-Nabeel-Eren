/* 
ICS4U
2018/05/15 v0.3
Game Summative
Person class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Person extends Rectangle {
   private int lives; // Private integer variable for the number of lives.
   
   // Default constructor for the Person class
  Person() {
    super();
    lives = 0;
  }
  
  // Constructor that takes in parameters for lives, xPos and yPos
  Person(int health, float x, float y) {
    super(x, y);
    this.lives = health;
  }
  
  // Update method to update the players state..
  void update() {
  }
  
  // Show method to show the player object
  void show() {
    fill(255);
    rect(getX(), getY(), getWidth(), getHeight()); // Shows player as a rectangle on screen.
  }
  
  // Move method to move the person on screen
  void move(char direction) {
    float v = 100;
    if (direction == 'u') { // For moving up
      setPos(getX(), getBottom() - v); // Will substract to move it up screen
    } else if (direction == 'd') { // For moving down
      setPos(getX(), getBottom() + v);
    } else if (direction == 'r') { // For moving right
      setPos(getX() + v, getBottom());
    } else if (direction == 'l') { // For moving left
      setPos(getX() - v, getBottom());
    }
    updatePos(); // Updating the coordinates of the right, top and middle
  }
  
  // Series of getter and setter methods.
  
  // Setter method for lives
  void setLives(int health) {
    this.lives = health;
  }
  
  // Getter/accessor for the lives
  int getLives() {
    return this.lives;
  }

}
