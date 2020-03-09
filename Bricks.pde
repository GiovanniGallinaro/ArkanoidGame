class Bricks {
  float x, y;
  float w, h;
  float r, g, b;
  color c;
  int life;
  PImage brickImg;
  int score;
  int bonusMalus;
  int t;

  Bricks(float x_, float y_, int life_, String brickImg_) {
    x = x_;
    y = y_;
    w = brickW;
    h = brickH;
    brickImg = loadImage(brickImg_);
    t = int(random(colori.length));
    if (life_ == 3)
    {
      r = 240;
      g = 200;
      b = 50;
      //int t = int(random(0,5));
      //r = red(colori[t]);
      //g = green(colori[t]);
      //b = blue(colori[t]);
      score = 200;
    } else if (life_ == 2)
    {
      r = 0;
      g = 0;
      b = 255;
      score = 100;
    } else {
      r = 255;
      g = 255;
      b = 255;
      score = 50;
    }
    life = life_;
    bonusMalus = int(random(19));
  }

  void display() {
    if (life == 3)
    {
      r = 240;
      g = 200;
      b = 50;
      //r = red(colori[t]);
      //g = green(colori[t]);
      //b = blue(colori[t]);
    } else if (life == 2)
    {
      r = 0;
      g = 0;
      b = 255;
      //r = red(colori[t]);
      //g = green(colori[t]);
      //b = blue(colori[t]);
    } else {
      r = 255;
      g = 255;
      b = 255;
    }
    //imageMode(CENTER);
    //tint(r, g, b);
    //image(brickImg, x, y, w, h);
    fill(r, g, b);
    stroke(0);
    strokeWeight(4);
    rect(x, y, w, h);
    strokeWeight(1);
  }

  int caught() {
    life--;
    if (life == 0)
    {
      x = -1000;
      return -1;
    }
    return 0;
  }
  
  Bonus getBonus()
  {
    Bonus bonus = new Bonus(3, bonusMalus, x, y);
    return bonus;
  }
}
