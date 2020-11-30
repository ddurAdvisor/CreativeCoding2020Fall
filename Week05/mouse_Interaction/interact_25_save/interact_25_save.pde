int count = 1;

void setup(){
  size(600, 400);
  background(255);
  noStroke();
}

void draw() {
  if (mousePressed == true) {
    fill(255, 0, 0, 40);
    ellipse(mouseX, mouseY, 30, 30);
  }
  if (keyPressed == true) {
    save("frame" + count + ".png");
    delay(500);
    count++;
  }
}
