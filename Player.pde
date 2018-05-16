/* 
ICS4U
2018/05/16
Game Summative
Player class
Made by Eren Sulutas and Nabeel Warsalee
*/

public class Player extends Person {
  PImage playerBody = loadImage(/* enter name of file */);
  
  // Default constructor that sets the values to zero
  public Player() {
    super();
  }

  // Constructor that initializes the Player 
  public Player(float xStart, float yStart) {
    super(3, xStart, yStart); // Automatically sets the lives to 3
  }

  // Show method that shows the player on the screen, takes in a PImage as a parameter and displays that TO BE USED ONCE PLAYER SPRITE IS MADE
  //void show() {
  //  image(playerBody, 800, 800, 100, 100); // Displaying image at x and y with dimensions 50x50
  //}
  
  // Method to print the information of the object.
  void toConsole() {
    println("Lives : " + getLives() + "   X Position : " + getX() + "   Y Position : " + getY());
  }

}