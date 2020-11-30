Button[] bt;

float speed = 0;
float easing = 0.07;
float btWidth = 50;
float btHeight = 20;
color brushColor = 255;

void setup() {
  size(600, 400);
  background(0);
  bt = new Button[3];

  for (int i = 0; i < bt.length; i ++) {
    color cc = color(random(255), random(255), random(255));
    bt[i] = new Button(50, 50+(btHeight+10)*i, btWidth, btHeight, cc);
  }
}

void draw() {
  //background(0);
  pushStyle();
  fill(0);
  noStroke();
  rect(0, 0, btWidth*2+10, 150);
  popStyle();

  float target = dist(mouseX, mouseY, pmouseX, pmouseY);
  speed += (target - speed) * easing;
  if (mousePressed) {
    strokeWeight(speed/2);
    stroke(brushColor);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }

  for (int i = 0; i < bt.length; i ++) {
    bt[i].showButton();
    if (bt[i].pickColor) {
      brushColor = bt[i].buttonColor;
      bt[i].pickColor = false;
    }
  }
}
