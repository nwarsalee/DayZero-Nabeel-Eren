/* 
 ICS4U
 2018/05/22
 Game Summative
 Player class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Enemy extends Person {
  // PImage playerBody = loadImage(/* enter name of file */);

  // Default constructor that sets the values to zero
  Enemy() {
    super();
  }

  // Constructor that initializes the Enemy, sets the life to 1
  Enemy(float xStart, float yStart) {
    super(1, xStart, yStart); // Automatically sets the lives to 1
  }

  // Constructor that initializes the Enemy, sets the life to whatever the user wants 
  Enemy(int lives, float xStart, float yStart) {
    super(lives, xStart, yStart);
  }

  // Method to check if the enemy is dead
  boolean isDead(ArrayList<Bullet> bullets) {
    // Method to show the bullets
    for (Bullet bullet : bullets) {
      if (intersect(bullet)) {
        // bullet.getIdentifier(); method to get the ID of the bullet so they know who killed it (EXTENSION)
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  // Show method that shows the player on the screen, takes in a PImage as a parameter and displays that TO BE USED ONCE PLAYER SPRITE IS MADE
  void show() {
    fill(0, 255, 0);
    noStroke();
    rect(getX(), getBottom(), getWidth(), getHeight()); // Shows player as a rectangle on screen.
  }

  // Method to print the information of the object.
  void toConsole() {
    println("Lives : " + getLives() + "   X Position : " + getX() + "   Y Position : " + getY());
  }
}
