String selectedFile;

PController pc;
boolean mouseDown;
PVector mouseLoc, mousePLoc, mouseVel;
PImage origionImg;
PFont font;

int tintIndex = 0;

void setup() {
  selectInput("Select a file to process:", "loadFile");
  size(1280, 720, OPENGL);
  imageMode(CENTER);
  font = createFont("微软雅黑",18,true);
  smooth();

  stroke(255);
  ellipseMode(RADIUS);

  pc = new PController();
  mouseLoc = new PVector(0, 0, 0);
  mousePLoc = new PVector(0, 0, 0);
  mouseVel = new PVector(0, 0, 0);
}

void draw() {
  background(0);
  //displayImg();

  if (mouseDown) pc.addParticles(10, mouseLoc, mouseVel);
  pc.repulse();
  pc.update(origionImg);
  pc.display();
  textFont(font);
  fill(200);
  text("仅支持1280X720大小的图像",30,30);
  text("Press Mouse to draw generative image",30,50);
  text("Press key ' f ' will generate rectangle element shape",30,70);
  text("Press key ' y ' will generate circle element shape with stroke",30,90);
  text("Press key ' p ' will generate dot element shape",30,110);
}

void mouseDragged() {
  mouseMoved();
}

void mousePressed() {
  mouseDown = true;
}

void mouseReleased() {
  mouseDown = false;
}

void mouseMoved() {
  mousePLoc.set(pmouseX, pmouseY, 0);
  mouseLoc.set(mouseX, mouseY, 0);
  mouseVel = PVector.sub(mouseLoc, mousePLoc);
}

void loadFile(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {  
    selectedFile = selection.getAbsolutePath();
    origionImg = loadImage(selectedFile);
  }
}

void displayImg() {
  if (tintIndex < 255) {
    if (keyPressed) {
      if (key == 'a') {
        tintIndex++;
      }
    }
  }
  if (tintIndex > 0) {
    if (keyPressed) {
      if (key == 'z') {
        tintIndex--;
      }
    }
  }
  tint(255, tintIndex);
  image(origionImg, width/2, height/2);
}

