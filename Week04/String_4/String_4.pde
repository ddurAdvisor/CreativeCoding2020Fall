PFont myFont1;
PFont myFont2;

String str = "this is a ...";

void setup(){
  size(600, 600);
  myFont1 = createFont("Arial", 24);
  myFont2 = createFont("微软雅黑", 24);
}

void draw(){
  background(255);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(myFont1);
  textSize(60);
  text(str, width/2, 300);
  textFont(myFont2);
  textSize(12);
  text("这是一个。。。", width/2, 360);
  stroke(255,0,0);
  point(50, 300);
}
