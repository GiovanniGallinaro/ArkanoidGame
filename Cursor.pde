class Cursor{
  float w, h;
  float x, y;
  int frames;
  int i;
  PImage vaus;
  
  Cursor(float w_){
    w = w_;
    h = 40;
    x = width/2;
    y = height - h/2 - y_offset - 20;
    i = 0;
    frames = 0;
    vaus = loadImage("vaus.png");
  }
  
  void move(float x_, float h){
    x = x_;
    y = h - this.h/2 - y_offset - 20;
  }
  
  void display(){
    if (frames < 59)
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
    PImage v = vaus.get(152*i, 0, 152, 56);
    imageMode(CENTER);
    tint(255);
    noStroke();
    image(v, x, y, w, 44);
  }
  
  void setPosition(float x_)
  {
    x = x_;
  }
}
