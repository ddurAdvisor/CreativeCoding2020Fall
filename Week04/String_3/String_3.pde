PFont myFont1;
PFont myFont2;
String[] str;

void setup() {
  size(600, 600);
  myFont1 = createFont("Arial", 15);
  myFont2 = createFont("Impact", 15);
  str = loadStrings("newsToday.txt");
}

void draw() {
  background(255);
  for (int i = 0; i < str.length; i++) {
    if (i%2==0) {
      textFont(myFont1);
    } else {
      textFont(myFont2);
    }
    fill(50*i);
    text(str[i], 50, 50 + 90 * i, 400, 600);
  }
}
