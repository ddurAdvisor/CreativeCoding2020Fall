float speed = 0;
float easing = 0.03;

void setup() {
  size(600, 400);
  background(0);
  stroke(255);
}

void draw() {
  float target = dist(mouseX, mouseY, pmouseX, pmouseY);
  speed += (target - speed) * easing;
  if(mousePressed == true){
    strokeWeight(speed/2);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
  println(speed);
}
