float[] d;
d = new float[10];

size(600, 200);
for(int  i = 0; i < 10; i ++){
  d[i] = random(5, 30);
  ellipse(50+50*i, 100, d[i], d[i]);
}
