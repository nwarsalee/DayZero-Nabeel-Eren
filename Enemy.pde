/* 
 ICS4U
 2018/05/26 v5
 Game Summative
 Enemy Class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Enemy extends Person {
  // PImage playerBody = loadImage(/* enter name of file */);
  private float x, y, coolDown, c = 100; // Float values for the enemy's x and y location and for it's cool down time
  
  // Default constructor that sets the values to zero
  Enemy() {
    super();
    x = 0;
    y = 0;
    coolDown = 0;
  }

  // Constructor that initializes the Enemy, sets the life to 1
  Enemy(float xStart, float yStart) {
    super(1, xStart, yStart); // Automatically sets the lives to 1
    x = xStart;
    y = yStart;
    coolDown = c;
  }

  // Constructor that initializes the Enemy, sets the life to whatever the user wants 
  Enemy(int lives, float xStart, float yStart) {
    super(lives, xStart, yStart);
    x = xStart;
    y = yStart;
    coolDown = c;
  }

  // Method to have the enemy move towards the player
  void moveStep(Player p1) {
    boolean moveX = true, moveY = true; // Boolean vars for if the enemy is moving in the positive of the y and x
    // Changing the x pos numbers depending on where the player is
    if (p1.getX() > x) { // If the enemy has to move to the right
      x++;
      moveX = true;
    } else if (p1.getX() <= x) { // If the enemy has to move to the left
      x--;
      moveX = false;
    }
    // Changing the y pos numbers depending on where the player is
    if (p1.getBottom() > y) { // If the enemy has to move downwards
      y++;
      moveY = false;
    } else if (p1.getBottom() <= y) { // If the enemy has to move upwards
      y--;
      moveY = true;
    }

    // Determining whether or not the enemy can move a full block space
    if (x%50 == 0) {
      setPos(x, getBottom());
      // Setting its face direction
      if (moveX) {
        setDir('r');
      } else {
        setDir('l');
      }
    }
    if (y%50 == 0) {
      setPos(getX(), y);
      // Setting its face direction
      if (moveY) {
        setDir('u');
      } else {
        setDir('d');
      }
    }
    updatePos();
  }
  
  // Method to check if the zombie is on top of the player and lets them attack
  boolean attacking(Player p1) {
    if (this.intersect(p1) && coolDown == c) {
      coolDown = 0;
      return true;
    } else {
      if (coolDown < c) {
        coolDown++;
      }
      return false;
    }
  }

  // Method to check if the enemy is hit
  boolean isHit(ArrayList<Bullet> bullets) {
    // Method to show the bullets
    for (Bullet bullet : bullets) {
      if (intersect(bullet)) {
        return true;
      }
    }
    return false;
  }
  
  // Method to return the index of the bullet that kills the player
  int bulletHit(ArrayList<Bullet> bullets) {
    for (int i=0; i<bullets.size(); i++) {
      if (intersect(bullets.get(i))) {
        return i; // Sending index of the bullet that hit
      }
    }
    return -1; // If no bullet hit, sends -1 back
  }

  // Show method that shows the player on the screen, takes in a PImage as a parameter and displays that TO BE USED ONCE PLAYER SPRITE IS MADE
  void show() {
    imageMode(CORNER);
    if (getDir() == 'r') { // If it's facing right show the right img
      image(imgZombie, getX(), getBottom(), getWidth(), getHeight());
    }
  }

  // Method to print the information of the object.
  void toConsole() {
    println("Lives : " + getLives() + "   X Position : " + getX() + "   Y Position : " + getY());
  }
}
