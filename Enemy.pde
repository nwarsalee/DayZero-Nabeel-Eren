/* 
 ICS4U
 2018/06/06 v2
 Game Summative
 Enemy Class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Enemy extends Person {
  // PImage playerBody = loadImage(/* enter name of file */);
  private float x, y, coolDown, c = 100; // Float values for the enemy's x and y location and for it's cool down time
  private int player; // Int for the player that the zombie is following
  
  // Default constructor that sets the values to zero
  Enemy() {
    super();
    x = 0;
    y = 0;
    player = 0;
    coolDown = 0;
  }

  // Constructor that initializes the Enemy, sets the life to 1
  Enemy(float xStart, float yStart) {
    super(1, xStart, yStart); // Automatically sets the lives to 1
    x = xStart;
    y = yStart;
    player = 1;
    coolDown = c;
  }
  
  // Constructor that initializes the Enemy, sets the life to 1
  Enemy(char dir, float xStart, float yStart) {
    super(1, xStart, yStart, dir); // Automatically sets the lives to 1
    x = xStart;
    y = yStart;
    coolDown = c;
  }
  
  // Constructor that initializes the Enemy, sets the life to 1 and takes in a player parameter
  Enemy(char dir, float xStart, float yStart, int p) {
    super(1, xStart, yStart, dir); // Automatically sets the lives to 1
    x = xStart;
    y = yStart;
    player = p;
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
    // Changing the x pos numbers depending on where the player is
    if (p1.getX() > getX()) { // If the enemy has to move to the right
      x++;
      if (x % 50 == 0) {
        move('r');
      }
    } else if (p1.getX() < getX()) { // If the enemy has to move to the left
      x--;
      if (x % 50 == 0) {
        move('l');
      }
    }
    // Changing the y pos numbers depending on where the player is
    if (p1.getBottom() > getBottom()) { // If the enemy has to move downwards
      y++;
      if (y % 50 == 0) {
        move('d');
      }
    } else if (p1.getBottom() < getBottom()) { // If the enemy has to move upwards
      y--;
      if (y % 50 == 0) {
        move('u');
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
      image(imgZombieRight, getX(), getBottom(), getWidth(), getHeight());
    } else if (getDir() == 'l') { // If it's facing left show the left img
      image(imgZombieLeft, getX(), getBottom(), getWidth(), getHeight());
    } else if (getDir() == 'u') { // If it's facing up show the up img
      image(imgZombieUp, getX(), getBottom(), getWidth(), getHeight());
    } else { // If it's facing down (aka none of the above) show the down img
      image(imgZombieDown, getX(), getBottom(), getWidth(), getHeight());
    }
  }
  
  // Method to get the player that it's following
  int getPlayer() {
    return player;
  }
  
  // Method to set the player it's following
  void setPlayer(int p) {
    player = p;
  }
}
