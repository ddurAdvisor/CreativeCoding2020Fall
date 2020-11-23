Ball[] myBalls;
int num = 200;
boolean displayBall;

void setup() {
  size(600, 600);
  background(0);
  initiateData();
}

void initiateData() {
  myBalls = new Ball[num];
  for (int i = 0; i < myBalls.length; i ++) {
    float r2 = random(20, 80);
    myBalls[i] = new Ball(random(width), random(height), r2);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < myBalls.length; i ++) {
    fill(255);
    if (displayBall) {
      myBalls[i].show(i);
    }
    myBalls[i].update();
  }
}

void keyPressed() {
  if (key == 'r') {
    initiateData();
  }
  if (key == 'd') {
    if (displayBall) {
      displayBall = false;
    } else {
      displayBall = true;
    }
  }
}
