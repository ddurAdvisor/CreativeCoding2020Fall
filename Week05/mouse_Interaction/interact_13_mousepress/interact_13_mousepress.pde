int x, y, w, h;

void setup() {
  size(600, 400);
  background(0);
  noStroke();
  w = 200;
  h = 150;
  x = width/2 - w/2;
  y = height/2 - h/2;
}

void draw() {
  background(0);
  if ((mouseX > x) && (mouseX < x + w) && 
      (mouseY > y) && (mouseY < y + h) && 
      mousePressed == true) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  rect(x, y, w, h);
}
