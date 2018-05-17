/* 
ICS4U
2018/05/17
Game Summative
Rectangle class
Made by Eren Sulutas and Nabeel Warsalee
*/

class Rectangle {
  private float l, b, w, h, r, t, mx, my; // Private integer fields for left, bottom, width and height (two others for top and right)

  // Constructor method that automatically sets the fields to zero
  public Rectangle() {
    this.l = 0;
    this.b = 0;
    this.w = 0;
    this.h = 0;
    // For top right
    this.r = 0;
    this.t = 0;
  }

  // Constructor method that takes in four integer parameters to set the fields of the rectangle
  public Rectangle(float left, float bottom, float wid, float heit) {
    this.l = left;
    this.b = bottom;

    // Sets the value of the width field, if it's a negative integer, sets it to 0
    if (wid >= 0) {
      this.w = wid;
    } else {
      this.w = 0;
    }
    // Sets the value of the height field, if it's a negative integer, sets it to 0
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
  
  // Constructor method that takes in two integer parameters to set the fields of the rectangle (only sets the bottom left coordinate; length and width set to 50x50)
  public Rectangle(float left, float bottom) {
    this.l = left;
    this.b = bottom;

    // Sets the value of the width field to 50
    this.w = 50;
    
    // Setting the value of the height field to 50
    this.h = 50;

    // For the top right coordinates, will just be the coord + the length of the respective side
    this.r = this.l + this.w;
    this.t = this.b + this.h;

    // Finding the central coords
    this.mx = this.l + this.w/2;
    this.my = this.b + this.h/2;
  }

  // Mutator method to set the values of the fields
  public void setPos(float left, float bottom) {
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

  // Intersection method to see if the two rectangle objects collide
  public Boolean intersect(Rectangle b) {
    Rectangle left, other; // Creating new object for the rectangle that is the most left
    // Determines which rectangle is the furthest left
    if (this.l <= b.l) {
      left = this;
      other = b;
    } else {
      left = b;
      other = this;
    }

    // Checks to see if the top left coord is inside the rectangle of the left rectangle
    if (other.mx >= left.l && other.mx <= left.r && other.my >= left.b && other.my <= left.t) {
      println("Intersection");
      return true;
    } else {
      return false;
    }
  }

  //
  public boolean contains(Rectangle other) {
    if (other.l >= this.l && other.b >= this.b && other.r <= this.r && other.t <= this.t) {
      return true;
    } else {
      return false;
    }
  }
  
  // Updating pos method
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
   * post : Returns the left coord as an integer*/
  public float getX() {
    return this.l;
  }

  /* Accessor method that returns the bottom coordinate of the rectangle
   * pre : none
   * post : Returns the bottom coord as an integer*/
  public float getBottom() {
    return this.b;
  }

  /* Accessor method that returns the bottom coordinate of the rectangle (y coordinate)
   * pre : none
   * post : Returns the bottom coord as an integer*/
  public float getY() {
    return this.t;
  }

  /* Accessor method that returns the width of the rectangle
   * pre : none
   * post : Returns the width as an integer*/
  public float getWidth() {
    return this.w;
  }

  /* Accessor method that returns the height of the rectangle
   * pre : none
   * post : Returns the height as an integer*/
  public float getHeight() {
    return this.h;
  }

  /* Mutator method that sets the top of the rectangle
   * pre : int
   * post : sets the top variable*/
  public void setY(float top) {
    this.t = top;
  }

  /* Mutator method that sets the left of the rectangle
   * pre : int
   * post : sets the left variable*/
  public void setX(float left) {
    this.l = left;
  }
}