import processing.io.*; //hardware i/o library
int grid = 20; //How big each grid square will be
PVector food;
int speed = 10;
boolean dead = true;
int highscore = 0;
Snake snake;


void setup() {
  size(500, 500);
  snake = new Snake();
  food = new PVector();
  newFood();
  //frameRate(8);
  GPIO.pinMode(5, GPIO.INPUT_PULLUP);//left
  GPIO.pinMode(6, GPIO.INPUT_PULLUP);//right
  GPIO.pinMode(13, GPIO.INPUT_PULLUP);//up
  GPIO.pinMode(26, GPIO.INPUT_PULLUP);//down
  GPIO.pinMode(12, GPIO.INPUT_PULLUP);//button
}

void draw() {
  background(0);
  fill(255);
  if (!dead) {

    if (frameCount % speed == 0) {
      snake.update();
    }
    snake.show();
    snake.eat();
    fill(255, 0, 0);
    rect(food.x, food.y, grid, grid);
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Score: " + snake.len, 10, 20);
  } 
  else {
    textSize(25);
    textAlign(CENTER, CENTER);
    text("Snake Game\nClick to start" + "\nHighscore: " + highscore, width/2, height/2);
    if (GPIO.digitalRead(12) == GPIO.LOW) {//button
      snake = new Snake();
      newFood();
      speed = 10;
      dead = false;
  }
    
  }
  //left
  if (GPIO.digitalRead(5) == GPIO.LOW) {
    snake.vel.x = -1;
    snake.vel.y = 0;
  //right
  } else if (GPIO.digitalRead(6) == GPIO.LOW) {
    snake.vel.x = 1;
    snake.vel.y = 0;
  //up
  } else if (GPIO.digitalRead(13) == GPIO.LOW) {
    snake.vel.y = -1;
    snake.vel.x = 0;
  //down
  } else if (GPIO.digitalRead(26) == GPIO.LOW) {
    snake.vel.y = 1;
    snake.vel.x = 0;
    print("DOWN");
  }
  
  
}

void newFood() {
  food.x = floor(random(width));
  food.y = floor(random(height));
  food.x = floor(food.x/grid) * grid;
  food.y = floor(food.y/grid) * grid;
}
