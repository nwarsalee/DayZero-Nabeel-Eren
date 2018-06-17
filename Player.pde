/* 
 ICS4U
 2018/06/17 v1
 Game Summative
 Player class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Player extends Person {
  private float stamina, s = 5; // Floats for the player's stamina and the stamina limit
  private int bullets, reload; // Int for the bullets the user has and the reload time

  // Default constructor that sets the values to zero
  Player() {
    super();
    stamina = 0;
    bullets = 0;
    reload = 0;
  }

  // Constructor that initializes the Player, takes in two float parameters for its position 
  Player(float xStart, float yStart) {
    super(3, xStart, yStart); // Automatically sets the lives to 3
    stamina = s;
    bullets = 7;
    reload = 0;
  }

  // Show method that shows the player on the screen using the PImage from the main class, uses different images for the different directions it faces
  // Takes in an int parameter for indicating which player is being shown
  void show(int p) {
    imageMode(CORNER);
    // If the p int is 1, shows player 1's sprite
    if (p == 1) {
      if (getDir() == 'r') { // If it's facing right show the right img
        image(playerImg[0][0], getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'l') { // If it's facing left show the left img
        image(playerImg[0][1], getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'u') { // If it's facing up show the up img
        image(playerImg[0][2], getX(), getBottom(), getWidth(), getHeight());
      } else { // If it's facing down (aka none of the above) show the down img
        image(playerImg[0][3], getX(), getBottom(), getWidth(), getHeight());
      }
    } else if (p == 2) { // If the p int is 2, shows player 2's sprite
      if (getDir() == 'r') { // If it's facing right show the right img
        image(playerImg[1][0], getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'l') { // If it's facing left show the left img
        image(playerImg[1][1], getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'u') { // If it's facing up show the up img
        image(playerImg[1][2], getX(), getBottom(), getWidth(), getHeight());
      } else { // If it's facing down (aka none of the above) show the down img
        image(playerImg[1][3], getX(), getBottom(), getWidth(), getHeight());
      }
    }
  }
  
  // Update method to update the players state... (Shooting stamina and reload progress)
  void update() {
    // If the stamina is less than the limit, increases it by 1
    if (stamina < s) {
      stamina++;
    }
    // If there are no bullets, adds one to the reload counter
    if (bullets == 0) {
      reload++;
    }
    // If the reload counter reaches 60, sets the bullets to 7 and resets the reload counter to 0
    if (reload == 60) {
      bullets = 7;
      reload = 0;
    }
  }
  
  // Method to give a health point to the player
  void lifePoint() {
    if (getLives() < 5) { // If the lives are less than 5 (the max) adds one life point
      setLives(getLives()+1);
    }
  }
  
  // Method to check whether or not the player can shoot
  boolean canShoot() {
    // If the stamina counter reaches the limit, lets the user shoot and resets its stamina to 0
    if (stamina == s && bullets > 0) {
      stamina = 0;
      return true;
    } else {
      return false;
    }
  }
  
  // Method to take away a bullet
  void shoot() {
    bullets--;
  }
  
  // Method to reload the players bullets
  void reload() {
    bullets = 0; // Sets bullets to zero so that it triggers the reload counter in update()
  }
  
  // Accessor and setter methods...
  
  // Method that returns the reload value 
  int getProgress() {
    return reload;
  }
  
  // Method that returns the bullets in the user's magazine
  int getBullets() {
    return bullets;
  }
}
