PImage img;
float blurScale = 1;

void setup() {
  size(600, 600);
  background(0);
  img = loadImage("tulip800800.png");
}

void draw() {
  //background(0);
  for (int i = 0; i< 50; i ++) {
    int xx = (int)random(width);
    int yy = (int)random(height);
    color fc = img.get(xx, yy);
    fill(fc);
    noStroke();
    rotate(random(TWO_PI));
    rect(xx, yy, 5, 50);
  }
}



void keyPressed() {
  if (key == 'a') {
    blurScale ++;
  }
  if (key == 'z') {
    blurScale --;
  }
}
