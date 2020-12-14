int nLeafPoints = 8;
float[] xOutline;
float[] yOutline;
void defineLeafOutline(){
  xOutline = new float[nLeafPoints];
  yOutline = new float[nLeafPoints];
  for(int i=0; i<=nLeafPoints/2;i++){
    xOutline[i] = 2*i/(float)(nLeafPoints);
    yOutline[i] = (-pow((xOutline[i]-.5),2)+.25)*2;
    
    if(i>0 && i<=nLeafPoints/2){
      xOutline[nLeafPoints-i] = xOutline[i];
      yOutline[nLeafPoints-i] = -yOutline[i];
    }
  }
}

float[] xVeins;
float[] yVeins;
void defineVeins(){
  xVeins = new float[8];
  yVeins = new float[8];
  xVeins[0] = .2;
  xVeins[1] = .25;
  xVeins[2] = .4;
  xVeins[3] = .47;
  xVeins[4] = .6;
  xVeins[5] = .65;
  xVeins[6] = .8;
  xVeins[7] = .85;
  
  yVeins[0] = 0;
  yVeins[1] = .3;
  yVeins[2] = 0;
  yVeins[3] = .45;
  yVeins[4] = 0;
  yVeins[5] = .35;
  yVeins[6] = 0;
  yVeins[7] = .2;
}


float tempx;
float tempy;
//leafWidth is a fraction of leafLength
void drawLeaf(float x, float y, float leafLength, float leafWidth, float direction){
  beginShape();
  for(int i=0; i<xOutline.length;i++){
    tempx = xOutline[i]*cos(direction)*leafLength-yOutline[i]*sin(direction)*leafWidth*leafLength;
    tempy = xOutline[i]*sin(direction)*leafLength+yOutline[i]*cos(direction)*leafWidth*leafLength;
    vertex(x+tempx,y+tempy);
  }
  endShape(CLOSE);
}


float vx1,vx2,vy1,vy2;
void drawVeins(float x, float y, float leafLength, float leafWidth, float direction){
//  strokeWeight(leafLength/40);
  strokeWeight(1);
  stroke(leafColor);
  line(x,y,x+cos(direction)*leafLength,y+sin(direction)*leafLength);
  for(int i=0; i<4; i++){
    vx1 = xVeins[i*2]*cos(direction)*leafLength-yVeins[i*2]*sin(direction)*leafWidth*leafLength;
    vx2 = xVeins[i*2+1]*cos(direction)*leafLength-yVeins[i*2+1]*sin(direction)*leafWidth*leafLength;
    vy1 = xVeins[i*2]*sin(direction)*leafLength+yVeins[i*2]*cos(direction)*leafWidth*leafLength;
    vy2 = xVeins[i*2+1]*sin(direction)*leafLength+yVeins[i*2+1]*cos(direction)*leafWidth*leafLength;
    line(x+vx1,y+vy1,x+vx2,y+vy2);
    vx1 = xVeins[i*2]*cos(direction)*leafLength+yVeins[i*2]*sin(direction)*leafWidth*leafLength;
    vx2 = xVeins[i*2+1]*cos(direction)*leafLength+yVeins[i*2+1]*sin(direction)*leafWidth*leafLength;
    vy1 = xVeins[i*2]*sin(direction)*leafLength-yVeins[i*2]*cos(direction)*leafWidth*leafLength;
    vy2 = xVeins[i*2+1]*sin(direction)*leafLength-yVeins[i*2+1]*cos(direction)*leafWidth*leafLength;
    line(x+vx1,y+vy1,x+vx2,y+vy2);
  }
}
