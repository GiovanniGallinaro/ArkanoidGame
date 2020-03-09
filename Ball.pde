class Ball {
  int r;    //raggio
  float x, y;
  float ySpeed;
  float xSpeed;
  float[] xpos;
  float[] ypos;
  boolean canBounce;

  Ball(int r_, float x_, float y_, float ySpeed_) {
    r = r_;
    x = x_;
    y = y_;
    ySpeed = ySpeed_;
    xSpeed = 0;
    xpos = new float[r];
    ypos = new float[r];
    canBounce = true;
  }

  void move() {
    y += ySpeed;
    x += xSpeed;
    if (y < height/2) {
      canBounce = true;
    }
  }

  void yRevert() {
    ySpeed *= -1;
  }

  void xRevert() {  
    xSpeed *= -1;
  }

  void xRevert(Cursor c, float sensibility) {
    xSpeed = (x - c.x)/sensibility;
  }

  boolean brickIntersect(Bricks b) {
    float yDistance = abs(y - b.y);
    float xDistance = abs(x - b.x);    
    if (yDistance <= r + b.h/2 && xDistance <= r + b.w/2)
    {  
      return true;
    } else
    {  
      return false;
    }
  }

  boolean brickSideIntersect(Bricks b) {
    float xDistance = abs(x - b.x);
    if (y <= b.y + b.h/2 && y >= b.y - b.h/2 && xDistance <= r + b.w/2)
    {  
      return true;
    } else {
      return false;
    }
  }

  boolean cursorIntersect(Cursor c) {
    float yDistance = abs(y - c.y);
    float xDistance = abs(x - c.x);
    if (yDistance <= r + c.h/2 && y<(height - 40 - y_offset) && xDistance <= c.w/2 && canBounce)
    {  
      canBounce = false;
      return true;
    } else
    {  
      return false;
    }
  }

  boolean reachesTop() {
    if (y - r <= 0)
    {  
      return true;
    } else {
      return false;
    }
  }

  boolean reachesSide(float w) {
    if ((x + r >= w - x_offset) || (x - r <= x_offset))
    {  
      return true;
    } else {
      return false;
    }
  }

  boolean reachesBottom(float h)
  {  
    if (y + r >= h)
    {  
      return true;
    } else {
      return false;
    }
  }

  void changeSpeed(int i)
  {
    if (i > 0 && abs(ySpeed) < 8)
    {
      float temp = (abs(ySpeed) + 2.0)/abs(ySpeed);
      if (ySpeed > 0)
      {
        ySpeed += 2;
      } else {
        ySpeed -= 2;
      }
      if (xSpeed > 0) {
        xSpeed *= temp;
      } else if (xSpeed < 0) {
        xSpeed *= temp;
      }
    } else if (i < 0 && abs(ySpeed) > 2) {
      float temp = (abs(ySpeed) - 2.0)/abs(ySpeed);
      if (ySpeed > 0)
      {
        ySpeed -= 2;
      } else {
        ySpeed += 2;
      }
      if (xSpeed > 0) {
        xSpeed *= temp;
      } else if (xSpeed < 0) {
        xSpeed *= temp;
      }
    }
  }

  void display() {
    /*for (int i = 0; i < xpos.length-1; i++ ) {
     xpos[i] = xpos[i + 1];
     ypos[i] = ypos[i + 1];
     }
     // New location
     xpos[xpos.length-1] = x;
     ypos[ypos.length-1] = y;
     // Draw everything
     for (int i = 0; i < xpos.length; i++ ) {
     noStroke();
     fill(255);
     ellipse(xpos[i], ypos[i], i*2, i*2);
     }*/
    noStroke();
    fill(255);
    ellipse(x, y, r*2, r*2);
  }

  void erase(int i) {
    if (i > 0)
    {
      y = -1000;
    } else {
      y = 1000;
    }
    speed = 0;
  }
}
