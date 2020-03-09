class Bonus {
  float w, h;
  float x, y;
  int speed;
  int bonusMalus;
  int i;
  int frames;

  Bonus(int speed_, int bonusMalus_, float x_, float y_) {
    x = x_;
    y = y_;
    w = 60;
    h = 40;
    speed = speed_;
    bonusMalus = bonusMalus_;
    i = 0;
    frames = 0;
  }

  boolean cursorIntersect(Cursor c) {
    float yDistance = abs(y - c.y);
    float xDistance = abs(x - c.x);
    if (yDistance <= h/2 + c.h/2 && y <= c.y - c.h/2 && xDistance <= w/2 + c.w/2)
    {  
      return true;
    } else
    {  
      return false;
    }
  }

  Ball make(Cursor c, Ball[] b, int ballNumber, float speed, int bonusMalus) {
    Ball newBall = null;
    if (bonusMalus == 0)
    {
      c.w += 25;
    } else if (bonusMalus == 1)
    { 
      if (c.w >=5) {
        c.w = 2*c.w/3;
      }
    } else if (bonusMalus == 2)
    { 
      for (int i = 0; i<ballNumber; i++)
      {
        b[i].changeSpeed(1);
      }
    } else if (bonusMalus == 3)
    { 
      for (int i = 0; i<ballNumber; i++)
      {
        b[i].changeSpeed(-1);
      }
    } else if (bonusMalus == 4)
    {
      newBall = new Ball(10, width/2, height/2, -speed);
    }
    return newBall;
  }

  boolean reachesBottom(float h_)
  {  
    if (y + h/2 >= h_)
    {  
      return true;
    } else {
      return false;
    }
  }

  void move() {
    y += speed;
  }

  void display() {
    if (frames < 79)
    {
      frames++;
    } else {
      frames = 1;
      i = 0;
    }
    if (frames % 10 == 0)
    {
      i++;
    }
    if (bonusMalus < 2) {
      if (bonusMalus == 0)
      {
        PImage b0 = enlarge.get(80*i, 0, 80, 44);
        imageMode(CENTER);
        image(b0, x, y, w, h);
      } else if (bonusMalus == 1) {
        PImage b1 = redux.get(80*i, 0, 80, 44);
        imageMode(CENTER);
        image(b1, x, y, w, h);
      }
    } else if (bonusMalus >= 2 && bonusMalus <4) {
      if (bonusMalus == 2)
      {
        PImage b2 = fast.get(80*i, 0, 80, 44);
        imageMode(CENTER);
        image(b2, x, y, w, h);
      } else if (bonusMalus == 3) {
        PImage b3 = slow.get(80*i, 0, 80, 44);
        imageMode(CENTER);
        image(b3, x, y, w, h);
      }
    } else if (bonusMalus == 4) {
      PImage b4 = aggiungi.get(80*i, 0, 80, 44);
      imageMode(CENTER);
      image(b4, x, y, w, h);
    }
  }

  void caught() {
    y = 0;
    x = -1000;
    speed = 0;
  }
}
