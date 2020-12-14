class leaf{
  float theta0,dTheta,myWidth,myLength;
  int index;
  leaf(float thetaBranch, int index0){
    theta0 = thetaBranch+randomSign()*random(PI/6,PI/3);
    dTheta = 0;
    myWidth = random(minWidth,maxWidth);
    myLength = random(minLength,maxLength);
    index = index0;
  }

  void moveFromWind(){
    float dThetaWind = (((theta0+dTheta)-windDirection)%TWO_PI);
    if(dThetaWind>PI)
      dThetaWind = -(TWO_PI-dThetaWind);
    else if(dThetaWind<-PI)
      dThetaWind = TWO_PI+dThetaWind;

    theta0 = (theta0+TWO_PI)%TWO_PI;

    float forceOfLeaf = -(dTheta)/PI;
    float forceOfWind = -windVelocity*sin(dThetaWind);

    dTheta += (forceOfLeaf+forceOfWind)/15;
  }
  
  void rotate(float deltaTheta){
    dTheta+=deltaTheta;
  }

  void draw(float x, float y){
//    line(x,y,x+myLength*cos(theta0+dTheta),y+myLength*sin(theta0+dTheta));
    drawLeaf(x, y, myLength, myWidth, theta0+dTheta);
    if(drawVeins)
      drawVeins(x, y, myLength, myWidth, theta0+dTheta);
  }

  
  void draw(float[] coord){
    draw(coord[0],coord[1]);
  }
}

