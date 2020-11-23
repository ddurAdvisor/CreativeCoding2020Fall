float[][] b;
b = new float[10][3];

size(600, 600);

for (int  i = 0; i < 10; i ++) {
  b[i][0] = random(50, width-50);
  b[i][1] = random(50, height-50);
  b[i][2] = random(5, 30);
}

for (int i = 0; i < 10; i ++) {
  ellipse(b[i][0], b[i][1], b[i][2], b[i][2]);
}

for (int i = 0; i < 10; i ++) {
  for (int j = i+1; j < 10; j ++) {
    float d = sqrt((b[i][0]-b[j][0])*(b[i][0]-b[j][0]) + (b[i][1]-b[j][1])*(b[i][1]-b[j][1]));
    if (d < 100) {
      line(b[i][0], b[i][1], b[j][0], b[j][1]);
    }
  }
}
