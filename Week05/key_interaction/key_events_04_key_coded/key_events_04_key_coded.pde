float x, y;
int move = 2;
int d = 20;

void setup() {
  size(600, 400);
  rectMode(CENTER);
  x = width/2;
  y = height/2;
  background(0);
  noStroke();
  fill(255);
}

void draw() {
  background(0);
  // Move the rect using the arrow keys
  // keyCodes in clude ALT, CONTROL, SHIFT, UP, DOWN, LEFT, RIGHT
  if (key == CODED) {
    if (keyCode == UP) {
      y -= move;
    } else if (keyCode == DOWN) {
      y += move; 
    } else if (keyCode == LEFT) {
      x -= move;
    } else if (keyCode == RIGHT) {
      x += move;
    }
  }
  // If the rect is off screen bring it back
  if (x > width + d) x = -d;
  if (x < -d) x = width + d;
  if (y > height + d) y = -d;
  if (y < -d) y = height + d;
  rect(x, y, d, d);
}
