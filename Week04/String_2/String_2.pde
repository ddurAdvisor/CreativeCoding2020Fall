
size(450, 250);
colorMode(HSB, 100, 1, 1, 1);
background(0, 0, 0);
//textSize(72);
//fill(0);

String txt = "Hello World, what a wonderful world!";
float ww = 0;
for (int i = 0; i < txt.length(); i++) {
  char c = txt.charAt(i);
  textSize(floor(random(36,100)));
  int cl = int(c);
  println(cl);
  fill(cl, 1, 1, 0.5);
  noStroke();
  ellipse(ww, 150, 50, 50);
  //text(c, ww, 150);
  ww += textWidth(c);
}
