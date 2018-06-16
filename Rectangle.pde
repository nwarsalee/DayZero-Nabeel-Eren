/* 
ICS4U
2018/06/16 v1
Game Summative
Rectangle class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Rectangle {
  private float l, b, w, h, r, t, mx, my; // Private float fields for left, bottom, width and height and the middle x and y
  private float blockSize = (3*width)/96; // Float variable for the size of a block (grid size), the size of a block for a given width is (3*width)/96
  
  // Constructor method that automatically sets all fields to zero
  Rectangle() {
    this.l = 0;
    this.b = 0;
    this.w = 0;
    this.h = 0;
    // For top right
    this.r = 0;
    this.t = 0;
  }

  // Constructor method that takes in four float parameters to set the fields of the rectangle
  Rectangle(float left, float bottom, float wid, float heit) {
    this.l = left;
    this.b = bottom;

    // Sets the value of the width field, if it's a negative value, sets it to 0
    if (wid >= 0) {
      this.w = wid;
    } else {
      this.w = 0;
    }
    // Sets the value of the height field, if it's a negative value, sets it to 0
    if (heit >= 0) {
      this.h = heit;
    } else {
      this.h = 0;
    }

    // For the top right coordinates, will just be the coord + the length of the respective side
    this.r = this.l + this.w;
    this.t = this.b + this.h;

    // Finding the central coords
    this.mx = this.l + this.w/2;
    this.my = this.b + this.h/2;
  }
  
  // Constructor method that takes in two float parameters to set the fields of the rectangle (only sets the bottom left coordinate; length and width set to blockSize variable)
  Rectangle(float left, float bottom) {
    this.l = left;
    this.b = bottom;

    // Sets the value of the width field to 50
    this.w = blockSize;
    
    // Setting the value of the height field to 50
    this.h = blockSize;

    // For the top right coordinates, will just be the coord + the length of the respective side
    this.r = this.l + this.w;
    this.t = this.b + this.h;

    // Finding the central coords
    this.mx = this.l + this.w/2;
    this.my = this.b + this.h/2;
  }

  // Mutator method to set the values of the fields
  void setPos(float left, float bottom) {
    // Sets the value of the left field
    this.l = left;
    // Sets the value of the bottom field
    this.b = bottom;

    // For the top right coordinates, will just be the coord + the length of the respective side
    this.r = this.l + this.w;
    this.t = this.b + this.h;

    // Finding the central coords
    this.mx = this.l + this.w/2;
    this.my = this.b + this.h/2;
  }

  // Intersection method to see if the two rectangle objects collide, returns a boolean
  Boolean intersect(Rectangle b) {
    Rectangle left, other; // Creating new objects for the rectangle that is the most left
    // Determines which rectangle is the furthest left and sets the furthest rectangle as the object 'left'
    if (this.l <= b.l) {
      left = this;
      other = b;
    } else {
      left = b;
      other = this;
    }

    // Checks to see if the top left coord is inside the rectangle of the left rectangle
    if (other.mx >= left.l && other.mx <= left.r && other.my >= left.b && other.my <= left.t) {
      return true;
    } else {
      return false;
    }
  }
  
  // Intersection method to see if the two rectangle objects collide, takes in two float parameters to act as impending position of the rectangle
  Boolean intersect(float x, float y, Rectangle b) {
    Rectangle left, other; // Creating new objects for the rectangle that is the most left
    Rectangle next = new Rectangle(x, y); // Creating a new rectangle that has the impending coordinates of the other (the future rectangle)
    // Determines which rectangle is the furthest left
    if (next.l <= b.l) {
      left = next;
      other = b;
    } else {
      left = b;
      other = next;
    }

    // Checks to see if the top left coord is inside the rectangle of the left rectangle
    if (other.mx >= left.l && other.mx <= left.r && other.my >= left.b && other.my <= left.t) {
      return true;
    } else {
      return false;
    }
  }
  
  // Method to check if the rectangle is out of bounds (Uses the known dimensions of the gameplay box 1200x1200 with 200px borders)
  // Takes in two float parameters that act as the impending position of the rectangle
  boolean inBounds(float newX, float newY) {
    float shortest, longest, border; // Variables for the shortest and longest distance the object has to stay in bounds with and for the length of the border
    // Determining the border size through a ratio calculation for the length of the game area
    border = (width-(3*width/4))/2;
    shortest = border;
    longest = (3*width/4) + border;
    // If the x and y both lie within the range 200 to 1400, returns true to say it's in bounds
    if (newX >= shortest && newX < longest && newY >= shortest && newY < longest) {
      return true;
    } else {
      println("Out of bounds...");
      return false;
    }
  }
  
  // Method to check if the player is out of bounds (Uses the known dimensions of the gameplay box 1200x1200 with 200px borders)
  boolean inBounds() {
    float shortest, longest, border; // Variables for the shortest and longest distance the object has to stay in bounds with and for the length of the border
    // Determining the border size through a ratio calculation for the length of the game area
    border = (width-(3*width/4))/2;
    shortest = border;
    longest = (3*width/4) + border;
    // If the x and y both lie within the range 200 to 1400, returns true to say it's in bounds (uses its own left and bottom value)
    if (l >= shortest && l < longest && b >= shortest && b < longest) {
      return true;
    } else {
      println("Out of bounds...");
      return false;
    }
  }
  
  // Method to update the position/coordinates of the rectangle after its bottom and left have changed
  void updatePos() {
    // Updates bottom and right positions
    this.r = this.l + this.w;
    this.b = this.t - this.h;
    // Updates the central positions
    this.mx = this.l + this.w/2;
    this.my = this.b + this.h/2;
  }

  // Accessor Methods...

  /* Accessor method that returns the left coordinate of the rectangle (x coordinate)
   * pre : none
   * post : Returns the left coord as a float*/
  float getX() {
    return this.l;
  }

  /* Accessor method that returns the bottom coordinate of the rectangle (the y coordinate)
   * pre : none
   * post : Returns the bottom coord as a float*/
  float getBottom() {
    return this.b;
  }

  /* Accessor method that returns the width of the rectangle
   * pre : none
   * post : Returns the width as a float*/
  float getWidth() {
    return this.w;
  }

  /* Accessor method that returns the height of the rectangle
   * pre : none
   * post : Returns the height as a float*/
  float getHeight() {
    return this.h;
  }
  
  /* Accessor method that returns the blockSize for the game
   * pre : none
   * post : Returns the block/grid size as a float*/
  float getBlockSize() {
    return this.blockSize;
  }

  /* Mutator method that sets the left of the rectangle
   * pre : float
   * post : sets the left variable*/
  void setX(float left) {
    this.l = left;
  }
  
  /* Mutator method that sets the bottom of the rectangle
   * pre : float
   * post : sets the bottom variable*/
  void setBottom(float bot) {
    this.b = bot;
  }
}
