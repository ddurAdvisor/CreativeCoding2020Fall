Ball[] balls;
int totalNum = 100;

void setup() {
  size(800, 800);
  initiateData();
}

void initiateData() {
  balls = new Ball[totalNum];
  for (int i = 0; i < balls.length; i ++) {
    PVector p = new PVector(random(50, width-50), random(50, height-50));
    balls[i] = new Ball(p);
  }
}

void draw() {
  background(255);
  for (int i = 0; i < balls.length; i ++) {
    balls[i].update();
    balls[i].drawBall();
  }
  println(frameRate);
}

void keyPressed() {
  if (key == 'r') {
    initiateData();
  }
}
