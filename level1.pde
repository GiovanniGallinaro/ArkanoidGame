void level1() {
  bricksNumber = 60;
  float d = brickW/2.0;
  distance = x_offset + d;
  float r = brickH;
  riga = height/7.0 - 35;
  numeroRiga = 0;
  levelScore = 0;
  bricks = new Bricks[bricksNumber];
  float w_limit = width - x_offset;
  for (int i=0; i < bricksNumber; i++)
  {  
    if(numeroRiga < 1)
    {
      brickLife = 3;
    }
    else if(numeroRiga < 3)
    {
      brickLife = 2;
    }
    else
    {
      brickLife = 1;
    }
    bricks[i] = new Bricks(distance, riga, brickLife, "brick.png");
    levelScore += bricks[i].score;
    if (distance + d*2 < w_limit)
    {  
      distance += d*2;
    } else
    {  
      distance = x_offset + d;
      riga += r;
      numeroRiga++;
    }
  }
}
