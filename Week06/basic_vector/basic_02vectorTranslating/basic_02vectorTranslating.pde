import toxi.processing.*;
import toxi.geom.*;

Vec2D start;
Vec2D mouse;

float speed = 5;

void setup(){
  size(400,400);
  
  start = new Vec2D(0,0);
}

void draw(){
  background(200);
  mouse = new Vec2D(mouseX,mouseY);
  Vec2D direction = mouse.sub(start);
  direction.normalize();
  direction.scaleSelf(speed);
  start.addSelf(direction);
  
  strokeWeight(15);
  stroke(255);
  point(start.x,start.y);
}
