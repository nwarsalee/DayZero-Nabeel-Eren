/* 
 ICS4U
 2018/06/02 v1
 Game Summative
 Player class
 Made by Eren Sulutas and Nabeel Warsalee
 */

class Player extends Person {
  // PImage playerBody = loadImage(/* enter name of file */);

  // Default constructor that sets the values to zero
  Player() {
    super();
  }

  // Constructor that initializes the Player 
  Player(float xStart, float yStart) {
    super(3, xStart, yStart); // Automatically sets the lives to 3
  }

  // Show method that shows the player on the screen, takes in a PImage as a parameter and displays that TO BE USED ONCE PLAYER SPRITE IS MADE
  void show(int num) {
    imageMode(CORNER);
    if (num == 1) {
      if (getDir() == 'r') { // If it's facing right show the right img
        image(imgP1Right, getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'l') { // If it's facing left show the left img
        image(imgP1Left, getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'u') { // If it's facing up show the up img
        image(imgP1Up, getX(), getBottom(), getWidth(), getHeight());
      } else { // If it's facing down (aka none of the above) show the down img
        image(imgP1Down, getX(), getBottom(), getWidth(), getHeight());
      }
    } else if (num == 2) {
      if (getDir() == 'r') { // If it's facing right show the right img
        image(imgP2Right, getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'l') { // If it's facing left show the left img
        image(imgP2Left, getX(), getBottom(), getWidth(), getHeight());
      } else if (getDir() == 'u') { // If it's facing up show the up img
        image(imgP2Up, getX(), getBottom(), getWidth(), getHeight());
      } else { // If it's facing down (aka none of the above) show the down img
        image(imgP2Down, getX(), getBottom(), getWidth(), getHeight());
      }
    }
  }

  // Method to print the information of the object.
  void toConsole() {
    println("Lives : " + getLives() + "   X Position : " + getX() + "   Y Position : " + getY());
  }
}
