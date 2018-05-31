/* 
ICS4U
2018/05/31 v1
Game Summative
Person class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Person extends Rectangle {
   private int lives; // Private integer variable for the number of lives.
   private char dir = 'u'; // Variable for the direction the person is facing, automatically set to up
   private float stamina, s = 5; // Floats for the player's stamina and the stamina limit
  
  // Default constructor for the Person class
  Person() {
    super();
    lives = 0;
    stamina = 0;
  }
  
  // Constructor that takes in parameters for lives, xPos and yPos
  Person(int health, float x, float y) {
    super(x, y);
    this.lives = health;
    stamina = s;
  }
  
  // Update method to update the players state..
  void update() {
    if (stamina < s) {
      stamina++;
    }
  }
  
  // Show method to show the player object
  void show() {
    fill(255);
    rect(getX(), getBottom(), getWidth(), getHeight()); // Shows player as a rectangle on screen.
  }
  
  // Move method to move the person on screen
  void move(char direction) {
    float v = 50; // Float for how many pixels it moves per move
    dir = direction; // Changing facing directionn    // Selection statements for moving up, down, right and left. Uses method inBounds to check if it will be inbounds before doing move
    if (dir == 'u' && inBounds(getX(), getBottom() - v) && canMove(getX(), getBottom() - v, defenses)) { // For moving up
      setPos(getX(), getBottom() - v); // Will substract to move it up screen
    } else if (dir == 'd' && inBounds(getX(), getBottom() + v) && canMove(getX(), getBottom() + v, defenses)) { // For moving down
      setPos(getX(), getBottom() + v);
    } else if (dir == 'r' && inBounds(getX() + v, getBottom()) && canMove(getX() + v, getBottom(), defenses)) { // For moving right
      setPos(getX() + v, getBottom());
    } else if (dir == 'l' && inBounds(getX() - v, getBottom()) && canMove(getX() - v, getBottom(), defenses)) { // For moving left
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
  
  // Method to give a health point to the person (primarily used for the Player class)
  void lifePoint() {
    if (this.lives < 5) {
      this.lives++;
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
  boolean canMove(float newX, float newY, ArrayList<Crate> crates) {
    for (Crate crate : crates) {
      if (intersect(newX, newY, crate)) {
        return false;
      } else {
        return true;
      }
    }
    return true; // Default return
  }
  
  // Method to check whether or not the player can shoot
  boolean canShoot() {
    if (stamina == s) {
      stamina = 0;
      return true;
    } else {
      return false;
    }
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
