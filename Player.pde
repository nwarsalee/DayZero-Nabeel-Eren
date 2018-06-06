/* 
 ICS4U
 2018/06/06 v1
 Game Summative
 Player class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Player extends Person {
  private float stamina, s = 5; // Floats for the player's stamina and the stamina limit
  private int bullets, reload; // Int for the bullets the user has.

  // Default constructor that sets the values to zero
  Player() {
    super();
    stamina = 0;
    bullets = 0;
    reload = 0;
  }

  // Constructor that initializes the Player 
  Player(float xStart, float yStart) {
    super(3, xStart, yStart); // Automatically sets the lives to 3
    stamina = s;
    bullets = 7;
    reload = 0;
  }

  // Show method that shows the player on the screen, takes in a PImage as a parameter and displays that TO BE USED ONCE PLAYER SPRITE IS MADE
  void show(int num) {
    imageMode(CORNER);
    if (num == 1) {
      if (getDir() == 'r') { // If it's facing right show the right img
        image(playerImg[0][0], getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'l') { // If it's facing left show the left img
        image(playerImg[0][1], getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'u') { // If it's facing up show the up img
        image(playerImg[0][2], getX(), getBottom(), getWidth(), getHeight());
      } else { // If it's facing down (aka none of the above) show the down img
        image(playerImg[0][3], getX(), getBottom(), getWidth(), getHeight());
      }
    } else if (num == 2) {
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
  
  // Update method to update the players state..
  void update() {
    if (stamina < s) {
      stamina++;
    }
    if (bullets == 0) {
      reload++;
      println("Reload " + reload + " out of 100");
    }
    if (reload == 60) {
      bullets = 7;
      reload = 0;
    }
  }
  
  // Method to give a health point to the person (primarily used for the Player class)
  void lifePoint() {
    if (getLives() < 5) {
      setLives(getLives()+1);
    }
  }
  
  // Method to check whether or not the player can shoot
  boolean canShoot() {
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

  // Method to print the information of the object.
  void toConsole() {
    println("Lives : " + getLives() + "   X Position : " + getX() + "   Y Position : " + getY());
  }
}
