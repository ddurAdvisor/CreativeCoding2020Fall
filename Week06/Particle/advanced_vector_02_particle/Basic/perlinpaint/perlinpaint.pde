import processing.opengl.*;
import volatileprototypes.Panel4P.*;

public float redc=35, grec=250, bluc=245, sz=20;
public int paintmode=0;
public boolean ers=false;
Panel4P i;

void setup() {
  size(400,400, OPENGL);
  background(255);
  i = new Panel4P(this);
  i.addLabel("p","Paint");
  i.addButton("clr","Clear");
  i.addButton("ers","Erase", 0);
  i.addLabel("q","Stroke");
  String[] e = {"Ellipse","Line"};
  i.addButtonGroup("paintmode",e,0);
  i.addLabel("c","Color & Size");
  i.addSlider("redc","Red",0,255,redc);
  i.addSlider("grec","Green",0,255,grec);
  i.addSlider("bluc","Blue",0,255,bluc);
  i.addSlider("sz","Size",1,120,sz);
  i.autoSize();
}
void draw() {
  if (mousePressed) {
    if (!ers) {fill(redc,grec,bluc);stroke(redc,grec,bluc);} else {fill(255);stroke(255);}
    if (paintmode==0) {
      ellipse(mouseX,mouseY,noise(mouseX*.01,mouseY*.01)*sz,noise(mouseY*.01,mouseX*.01)*sz);
    } else {
      line(mouseX-noise(mouseX*.01,mouseY*.01)*sz+sz*.5,mouseY-noise(mouseY*.01,mouseX*.01)*sz+sz*.5,
           mouseX+noise(mouseX*.01,mouseY*.01)*sz-sz*.5,mouseY+noise(mouseY*.01,mouseX*.01)*sz-sz*.5);
    }
  }
}
public void clr() {
  fill(255);
  noStroke();
  rect(0,0,width,height);
}
