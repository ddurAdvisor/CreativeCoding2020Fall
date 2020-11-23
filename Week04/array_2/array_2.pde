float[][] d;
d = new float[10][3];

size(600, 200);

for(int  i = 0; i < 10; i ++){
  d[i][0] = random(50, width-50);
  d[i][1] = random(50, height-50);
  d[i][2] = random(5, 30);
}

for(int i = 0; i < 10; i ++){
  ellipse(d[i][0], d[i][1], d[i][2], d[i][2]);
}
