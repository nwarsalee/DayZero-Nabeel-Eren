/* 
 ICS4U
 2018/05/23
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
 
    // Method to have the enemy move towards the player
  void move(Player p1) {
    // Changing the x pos numbers depending on where the player is
    if (p1.getX() > x) { // If the enemy has to move to the right
      x++;
    } else if (p1.getX() <= x) { // If the enemy has to move to the left
      x--;
    }
    // Changing the y pos numbers depending on where the player is
    if (p1.getBottom() > y) { // If the enemy has to move downwards
      y++;
    } else if (p1.getBottom() <= y) { // If the enemy has to move upwards
      y--;
    }

    // Determining whether or not the enemy can move a full block space
    if (x%50 == 0) {
      setPos(x, getBottom());
    }
    if (y%50 == 0) {
      setPos(getX(), y);
    }
    updatePos();
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
