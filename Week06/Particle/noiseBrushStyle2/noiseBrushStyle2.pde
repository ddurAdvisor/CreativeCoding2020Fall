import processing.pdf.*;
String imageName = "portrait2.png";
int sampleNum = 30000;
int noiseDivideIndex = 100;
float segmentLength = 50;
float lineWeightThrehold = 0.4;
int countNumOfLines;
int singleLineLength = 3;

PImage img;
float xOff = 0.0;
float yOff = 0.0;
float x, y;

boolean savePDF;

void settings() {
  img = loadImage(imageName);
  size(img.width, img.height);
}

void setup() {
  //size(800, 800);
  //background(255);
  //img = loadImage("portrait.png");
  img.loadPixels();
  //noLoop();
}

void draw() {
  background(255);
  stroke(0);

  if (savePDF) {
    beginRecord(PDF, "output/noise"+imageName+".pdf");
  }
  for (int p = 0; p < sampleNum; p += 1) {
    x = random(img.width);
    y = random(img.height);
    for (int k = 0; k < singleLineLength; k ++) {

      //point(x, y);
      float x1 = x + width/2 - img.width/2;
      float y1 = y + height/2 - img.height/2;
      float x2 = x1 + segmentLength*(noise(x/noiseDivideIndex, y/noiseDivideIndex)-0.5);
      float y2 = y1 + segmentLength*(noise(y/noiseDivideIndex, x/noiseDivideIndex)-0.5);

      // read pixel value
      float lum = brightness(img.get(int(x), int(y)))/255;//get_grey_from_image(img, int(x), int(y));
      if (lum < lineWeightThrehold) {
        // stroke depends on luminosity
        strokeWeight(map(lum, 0, lineWeightThrehold, 2, 0.1));

        //paint
        //stroke(0, 0, 0, map(lum, 0, 1, 100, 10));

        stroke(0);

        strokeWeight(1);
        line(x1, y1, x2, y2);
        countNumOfLines++;
      }

      x = x2;
      y = y2;
    }
  }
  if (savePDF == true) {
    endRecord();
    savePDF = false;
  }
  println("countNumOfLines: "+countNumOfLines);
  noLoop();
}

// returns a greyscale value from image at given location
// retrun value is scaled between 0 and 1
float get_grey_from_image(PImage im, int x, int y) {
  // red value
  float r = red(im.pixels[x + y*im.width]);
  // green
  float g = green(im.pixels[x + y*im.width]);
  // blue
  float b = blue(im.pixels[x + y*im.width]);

  // use luminosity weighted average
  // https://www.johndcook.com/blog/2009/08/24/algorithms-convert-color-grayscale/
  float luminosity = (0.21*r + 0.72*g + 0.07*b) / 255.0;
  return luminosity;
}

void keyPressed() {
  if (key == 'r') {
    countNumOfLines = 0;
    loop();
  }
  if (key == 'p') {
    savePDF = true;
    loop();
  }
}
