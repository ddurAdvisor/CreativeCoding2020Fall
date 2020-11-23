
size(450, 250);
background(153);
//textSize(72);
fill(0);

String txt = "Hello World";
float ww = 0;
for (int i = 0; i < txt.length(); i++) {
  char c = txt.charAt(i);
  textSize(floor(random(36,100)));
  text(c, ww, 150);
  ww += textWidth(c);
}
