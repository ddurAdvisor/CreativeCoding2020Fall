Boolean brush = true;
int bx = 20;
int by = 20;
int bw = 50;
int bh = 20;
int by2 = by + bh + 10;

void setup() {
  size(600, 400);
  background(0);
  noStroke();
}

void draw() {
  if((mouseX > bx) && (mouseX < bx + bw) && (mouseY > by) && (mouseY < by + bh) && mousePressed == true) {
    fill(255, 0, 0);
    brush = true;
  } else {
    fill(100, 0, 0);
  }
  rect(bx, by, bw, bh);
  if ((mouseX > bx) && (mouseX < bx + bw) && (mouseY > by2) && (mouseY < by2 + bh) && mousePressed == true) {
    fill(255);
    brush = false;
  } else {
    fill(100);
  }
  rect(bx, by2, bw, bh);
  if(((mouseX < bx) || (mouseX > bx + bw) || (mouseY < by) || (mouseY > by + bh)) && brush == true && mousePressed == true) {
    fill(255, 0, 0, 50);
    ellipse(mouseX, mouseY, 20, 20);
  }
  if(((mouseX < bx) || (mouseX > bx + bw) || (mouseY < by2) || (mouseY > by2 + bh)) && brush == false && mousePressed == true) {
    fill(255, 50);
    ellipse(mouseX, mouseY, 40, 40);
  }
}
