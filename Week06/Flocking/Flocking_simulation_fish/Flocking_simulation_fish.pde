int fishNum = 500;
Fish[] fish = new Fish[fishNum];
 
boolean mouseDown = false;
 
void setup(){
  size(1280, 900);
  background(255);
  fill(0);
  //smooth();
 
  for(int i=0; i<fishNum; i++){
    fish[i] = new Fish(random(width), random(height));
  }
 
}
 
void mousePressed(){
  mouseDown = true;
}
void mouseReleased(){
  mouseDown = false;
}
 
 
 
void draw(){
  background(255);
 
  for(int i=0; i<fishNum; i++){
    fish[i].update();
  }
 
  for(int i = 0; i<fishNum-1; i++){
    for(int c = i+1; c<fishNum; c++){
 
 
      float d = dist(fish[i].x, fish[i].y, fish[c].x, fish[c].y)+1;
 
      if( d <= 15 ){
        fish[i].xv += .004*(fish[i].x - fish[c].x);
        fish[i].yv += .004*(fish[i].y - fish[c].y);
 
        fish[c].xv += .004*(fish[c].x - fish[i].x);
        fish[c].yv += .004*(fish[c].y - fish[i].y);
      }
      else if( d>50 && d <=80){
 
        fish[i].xv -= .000005*(fish[i].x - fish[c].x);
        fish[i].yv -= .000005*(fish[i].y - fish[c].y);
 
        fish[c].xv -= .000005*(fish[c].x - fish[i].x);
        fish[c].yv -= .000005*(fish[c].y - fish[i].y);
 
 
        fish[i].xv += ((fish[c].xv+fish[i].xv)/2-fish[i].xv)*.01;
        fish[i].yv += ((fish[c].yv+fish[i].yv)/2-fish[i].yv)*.01;
 
        //fish[c].xv += ((fish[i].xv+fish[c].xv)/2-fish[c].xv)*.005;
        //fish[c].yv += ((fish[i].yv+fish[c].yv)/2-fish[c].yv)*.005;
 
      }
       
      if(mouseDown){
           
         float d2 = dist(mouseX,mouseY, fish[i].x, fish[i].y);
         if(d2<100){
         fish[i].xv -= .002*(mouseX-fish[i].x)/d2;
         fish[i].yv -= .002*(mouseY-fish[i].y)/d2;
         }
      }
       
       
    }
  }
  //saveFrame("boids####.png");
 
 
 
 
 
  // println(frameRate);
 
 
}
 
 
 
