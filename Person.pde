/* 
ICS4U
2018/06/15 v1
Game Summative
Person class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Person extends Rectangle {
   private int lives; // Private integer variable for the number of lives.
   private char dir = 'u'; // Variable for the direction the person is facing, automatically set to up
  
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
  
  // Constructor that takes in parameters for lives, xPos and yPos and the direction
  Person(int health, float x, float y, char direction) {
    super(x, y);
    this.lives = health;
    this.dir = direction;
  }
  
  // Show method to show the person object
  void show() {
    fill(255);
    rect(getX(), getBottom(), getWidth(), getHeight()); // Shows person as a rectangle on screen by default
  }
  
  // Move method to move the person on screen
  void move(char direction) {
    float v = getBlockSize(); // Float for how many pixels it moves per move
    dir = direction; // Changing facing direction of person
    // Selection statements for moving up, down, right and left. Uses method inBounds to check if it will be inbounds before doing move and refers to method canMove to see if they're not obstructed
    if (dir == 'u' && inBounds(getX(), getBottom() - v) && canMove(getX(), getBottom() - v)) { // For moving up
      setPos(getX(), getBottom() - v); // Will substract to move it up screen
    } else if (dir == 'd' && inBounds(getX(), getBottom() + v) && canMove(getX(), getBottom() + v)) { // For moving down
      setPos(getX(), getBottom() + v);
    } else if (dir == 'r' && inBounds(getX() + v, getBottom()) && canMove(getX() + v, getBottom())) { // For moving right
      setPos(getX() + v, getBottom());
    } else if (dir == 'l' && inBounds(getX() - v, getBottom()) && canMove(getX() - v, getBottom())) { // For moving left
      setPos(getX() - v, getBottom());
    }
    updatePos(); // Updating the coordinates of the right, top and middle
  }
  
  // Method to take away health when a person is hit
  void hit() {
    if (this.lives > 0) {
      this.lives--;
    }
  }
  
  // Method to check if the person is dead
  boolean isDead() {
    if (this.lives == 0) {
      return true;
    } else {
      return false;
    }
  }
  
  // Method to see if whether or not the person can move towards a block (checks for crates)
  boolean canMove(float newX, float newY) {
    for (Crate crate : defenses) { // Traversing the defenses arrayList with a for-each loop
      if (intersect(newX, newY, crate)) {
        return false;
      }
    }
    return true; // Default return
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
  
  // Getter for the direction
  char getDir() {
    return this.dir;
  }
  
  // Getter for the direction
  void setDir(char direction) {
    this.dir = direction;
  }

}
