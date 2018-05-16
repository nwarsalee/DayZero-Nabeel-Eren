/* 
ICS4U
2018/05/15
Game Summative
Person class
Made by Eren Sulutas and Nabeel Warsalee
*/

public class Person {
   private int lives; // Private integer variable for the number of lives.
   private float xPos, yPos; // Private float values for the xPos and the yPos (with respect to the top left of a rectangle)
   
   // Default constructor for the Person class
  public Person() {
    lives = 0;
    xPos = 0;
    yPos = 0;
  }
  
  // Constructor that takes in parameters for lives, xPos and yPos
  public Person(int health, float x, float y) {
    this.lives = health;
    this.xPos = x;
    this.yPos = y;
  }
  
  // Update method to update the players state..
  void update() {
  }
  
  // Show method to show the player object
  void show() {
    rect(100, 100, xPos, yPos); // Shows player as a rectangle on screen.
  }
  
  // Move method to move the person on screen
  void move(float xMove, float yMove) {
    this.xPos += xMove;
    this.yPos -= yMove; // If the yMove is positive, will subtract from the current yPos to move it up.
  }
  
  // Series of getter and setter methods.
  
  // For the lives field
  void setLives(int health) {
    this.lives = health;
  }
  
  int getLives() {
    return this.lives;
  }
  
  // For the xPos
  void setX(float x) {
    this.xPos = x;
  }
  
  float getX() {
    return this.xPos;
  }
  
  // For the yPos
  void setY(float y) {
    this.yPos = y;
  }
  
  float getY() {
    return this.yPos;
  }

}
