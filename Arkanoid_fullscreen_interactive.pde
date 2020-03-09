import ddf.minim.*;

String typing = "";
String saved = "";
Data data;

Cursor cursor;
Bricks[] bricks;
Ball[] ball;
Bonus[] bonus;
Timer countdown;
Timer timer;

Minim minim;
AudioPlayer startSound;
AudioPlayer cursorHit;
AudioPlayer brickHit;
AudioPlayer gameOverSound;
AudioPlayer winSound;
AudioPlayer wallHit;
AudioPlayer bonusSound;
AudioPlayer malusSound;
AudioPlayer lifeLost;
AudioPlayer bg;

PImage life;

float distance;
float riga;
int numeroRiga;
int bricksNumber;
int remainingBricks;
int ballNumber;
int bonusNumber;
float speed;
float sensibility;

int lives = 3;
int brickLife;
float brickW;
float brickH;

int score = 0;
int totalScore;
int levelScore;
int timePredicted = 420000;
int bonusScore = 100;
//int lifeLostPenalty;

int gameState = -1;
int level = 1;

PImage background;
PImage brickImg;

PImage enlarge;
PImage redux;
PImage slow;
PImage fast;
PImage aggiungi;

float background_w;
float x_offset;
float y_offset;

color[]colori = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), color(255, 255, 0), color(255, 0, 255), color(0, 255, 255), color(255, 127, 0)};

void setup() {
  fullScreen(2);
  noCursor();
  background_w = (600.0*height)/700.0 + 100;
  float x_offset_temp = width - background_w;
  x_offset = x_offset_temp/2.0;
  y_offset = 120;

  smooth();

  ballNumber = 1;
  bonusNumber = 0;

  speed = 4;
  sensibility = 20;

  cursor = new Cursor(156);
  ball = new Ball[ballNumber];
  ball[0] = new Ball(10, width/2, height/2, speed);
  bonus = new Bonus[bonusNumber];
  countdown  = new Timer();
  timer = new Timer();
  brickW = (background_w/12.0);
  brickH = (20.0*brickW)/50.0;

  data = new Data("data.txt");

  level1();

  remainingBricks = bricksNumber;

  totalScore += levelScore;
  //lifeLostPenalty = 500;

  minim = new Minim(this);
  startSound = minim.loadFile("start.mp3");
  //startSound.play();
  cursorHit = minim.loadFile("2.mp3");
  brickHit = minim.loadFile("1.mp3");
  winSound = minim.loadFile("win.mp3");
  gameOverSound = minim.loadFile("gameover.mp3");
  bonusSound = minim.loadFile("bonus.mp3");
  malusSound = minim.loadFile("malus.mp3");
  wallHit = minim.loadFile("wall.mp3");
  lifeLost = minim.loadFile("lifelost.mp3");
  bg = minim.loadFile("tbhc.mp3");
  bg.rewind();
  bg.play();

  life = loadImage("life.gif");

  background = loadImage("sfondo.png");

  enlarge = loadImage("enlarge.png");
  redux = loadImage("redux.png");
  slow = loadImage("slow.png");
  fast = loadImage("fast.png");
  aggiungi = loadImage("aggiungi.png");

  //Client
  //oscP5 = new OscP5(this, 12000);//da che porta riceverò i dati
}

void draw() {     
  background(0);
  tint(255);
  //image(background, width/2, height/2, background_w, height);

  stroke(255);
  line(x_offset, cursor.y - 6, width - x_offset, cursor.y - 6);

  //inizializzo i vari componenti del gioco
  cursor.display();
  cursor.move(mouseX, height);

  for (int i=0; i<bricksNumber; i++)
  {  
    bricks[i].display();
  }

  if (gameState == -1)
  {
    insertName();
  } else if (gameState == 1)
  {  
    playMode();
  } else if (gameState == 2)
  {
    gameOver(1);
  } else if (gameState == 3)
  {
    gameOver(-1);
  } else if (gameState == 4)
  {  
    lifeLost();
  }

  rectMode(CORNER);
  fill(0);
  noStroke();
  rect(0, 0, x_offset, height);
  rect(width - x_offset, 0, x_offset, height);
  //rect(0, 0, width, y_offset);
  rect(0, height - y_offset, width, y_offset);
  rectMode(CENTER);

  //println(positionX*width);
}

void insertName() {
  textAlign(CENTER, CENTER);
  fill(255);
  textFont(loadFont("PixelForce-32.vlw"), 27);
  text("Insert name:", width/2, height/2 - 15);
  text(typing, width/2, height/2 + 15);
  PImage b0 = enlarge.get(80*4, 0, 80, 44);
  PImage b1 = redux.get(80*4, 0, 80, 44);
  PImage b2 = slow.get(80*4, 0, 80, 44);
  PImage b3 = fast.get(80*4, 0, 80, 44);
  PImage b4 = aggiungi.get(80*4, 0, 80, 44);
  imageMode(CENTER);
  tint(255);
  image(b0, x_offset + (background_w/12.0)*2, height/2 - 50);
  image(b1, x_offset + (background_w/12.0)*2, height/2 + 10);
  image(b2, x_offset + background_w - (background_w/12.0)*2, height/2 - 50);
  image(b3, x_offset + background_w - (background_w/12.0)*2, height/2 + 10);
  image(b4, width/2, height/2 - 100);
  textFont(loadFont("PixelForce-32.vlw"), 17);
  text("Allarga", x_offset + (background_w/12.0)*2, height/2 - 20);
  text("Riduci", x_offset + (background_w/12.0)*2, height/2 + 40);
  text("Rallenta", x_offset + background_w - (background_w/12.0)*2, height/2 - 20);
  text("Velocizza", x_offset + background_w - (background_w/12.0)*2, height/2 + 40);
  text("Aggiungi una pallina", width/2, height/2 - 70);
}

void playMode() {

  rectMode(CORNER);
  stroke(255);
  fill(255, 81, 0);
  //rect(x_offset, 0, (remainingBricks*(width - x_offset*2))/bricksNumber, 40);

  textAlign(LEFT);
  fill(255);
  textFont(loadFont("PixelForce-32.vlw"), 42);
  text(score, 10 + x_offset, 50);

  for (int j = 1; j <= lives; j++)
  {
    tint(255);
    image(life, width - 45*j - x_offset, 35, 35, 35);
  }
  textAlign(CENTER);
  text("Level "+ level, width/2, 50);

  for (int j = 0; j<ballNumber; j++)
  {
    ball[j].move();
    ball[j].display();

    //contatto palla-cursore
    if (ball[j].cursorIntersect(cursor))
    { 
      ball[j].yRevert();
      ball[j].xRevert(cursor, sensibility);
      cursorHit.play();
      cursorHit.rewind();
    }

    //contatto palla-mattone  
    int bricksIntersected = 0;
    int bricksSideIntersected = 0;
    for (int i=0; i<bricksNumber; i++)
    { 
      if (ball[j].brickIntersect(bricks[i]))
      {  
        if (ball[j].brickSideIntersect(bricks[i]))
        {  
          bricksSideIntersected++;
          ball[j].xRevert();
        } else {
          bricksIntersected++;
          ball[j].yRevert();
        }
        Bonus b = bricks[i].getBonus();
        if (bricks[i].caught() == -1)
        {
          score += bricks[i].score;
          if (b != null)
          {
            bonus = (Bonus[]) append(bonus, b);
            bonusNumber++;
          }
          remainingBricks--;
        }
        brickHit.play();
        brickHit.rewind();
      }
    }
    if (bricksSideIntersected != 0 && bricksIntersected > 0 && (bricksIntersected % 2) != 0)
    {
      ball[j].yRevert();
    }
    if (bricksIntersected != 0 && (bricksIntersected % 2) == 0)
    {  
      ball[j].yRevert();
    }

    //contatto palla-bordi
    if (ball[j].reachesTop())
    {  
      ball[j].yRevert();
      wallHit.play();
      wallHit.rewind();
    }
    if (ball[j].reachesSide(width))
    {  
      ball[j].xRevert();
      wallHit.play();
      wallHit.rewind();
    }
    if (ball[j].reachesBottom(height - y_offset))
    { 
      if (j != ballNumber - 1)
      {
        ball[j] = ball[ballNumber - 1];
      }
      ball = (Ball[]) shorten(ball);
      ballNumber--;
      //ball[j].erase(-1);
    }

    //vittoria
    if (remainingBricks == 0)
    {  
      ball[j].erase(1);
      int timeElapsed = timer.getElapsedTime();
      int timeScoreBonus = timePredicted - timeElapsed;
      if (timeScoreBonus > 0)
      {
        score += timeScoreBonus/200;
      }
      gameState = 2;
    }
  }

  for (int j = 0; j < bonusNumber; j++)
  {
    bonus[j].move();
    bonus[j].display();

    //contatto cursore-bonus
    if (bonus[j].cursorIntersect(cursor))
    {   
      Ball newb = bonus[j].make(cursor, ball, ballNumber, speed, bonus[j].bonusMalus);
      if (newb != null)
      {
        ball = (Ball[]) append(ball, newb);
        ballNumber++;
      }
      bonus[j].caught();
      score += bonusScore;
      if (bonus[j].bonusMalus < 5 && bonus[j].bonusMalus % 2 == 0)
      {  
        bonusSound.play();
        bonusSound.rewind();
      } else if (bonus[j].bonusMalus < 5 && bonus[j].bonusMalus % 2 != 0) {
        malusSound.play();
        malusSound.rewind();
      }
    } else if (bonus[j].reachesBottom(height))
    {  
      bonus[j].caught();
      if (j != bonusNumber - 1)
      {
        bonus[j] = bonus[bonusNumber - 1];
      }
      bonus = (Bonus[]) shorten (bonus);
      bonusNumber--;
    }
  }

  //sconfitta
  if (ballNumber == 0)
  {
    gameState = 4;
    lives--;
    if (lives > 0)
    {
      countdown.start();
      lifeLost.play();
      lifeLost.rewind();
    }
    //score -= lifeLostPenalty;
  }

  if (lives == 0)
  { 
    gameState = 3;
  }
}

void gameOver(int j)
{  
  rectMode(CENTER);
  fill(0);
  rect(width/2, height/2, width, height);
  fill(255);
  textAlign(CENTER, CENTER);
  textFont(loadFont("PixelForce-32.vlw"), 64);
  if (j < 0) {
    text("GAME OVER", width/2, height/2 - 195 - y_offset);
    gameOverSound.play();
  } else {
    text("YOU WON!", width/2, height/2 - 195 - y_offset);
    winSound.play();
  }
  textFont(loadFont("PixelForce-32.vlw"), 32);
  text("Score: " + score, width/2, height/2 - 140 - y_offset);
  if (data.find(saved, score) == false)
  {
    data.set_Name(saved, score);
    data.sortNames();
    data.saveNames("data.txt");
  }
  textAlign(RIGHT);
  for (int i = 0; i <= 6; i++) {
    if (data.length() != 0 && (data.length() - 1) >= i) {
      text(data.print(i), width/2  + width/6 - 60, height/2 - 40 + 35*i - y_offset);
    }
  }
  textAlign(CENTER);
  text("Press any key to Restart", width/2, height/2 + 35*7 - y_offset);
  if (keyPressed)
  {  
    reset();
  }
}

void lifeLost()
{
  ballNumber = 1;
  ball = new Ball[ballNumber];
  ball[0] = new Ball(10, width/2, height/2 - 115, speed);
  ball[0].display();
  int countdownDisplay = (countdown.second() + 1)*(-1) + 4;
  textAlign(CENTER);
  textFont(loadFont("PixelForce-32.vlw"), 64);
  if (countdownDisplay != 0) {
    text(countdownDisplay, width/2, height/2 - 138);
  }
  if (countdown.getElapsedTime() >= 3000)
  {
    gameState = 1;
  }
}

void keyPressed() {
  if (key == '\n' && (gameState == -1 || gameState == 1))
  {
    saved = typing;
    typing = "";
    countdown.start();
    timer.start();
    gameState = 4;
  } else if (key == '\b') {
    int l = typing.length();
    if (l > 0)
    {
      typing = typing.substring(0, l - 1);
    }
  } else {
    typing = typing + key;
  }
}

void reset()
{  
  gameState = 4;
  lives = 3;
  score = 0;
  setup();
  countdown.start();
  timer.start();
}
