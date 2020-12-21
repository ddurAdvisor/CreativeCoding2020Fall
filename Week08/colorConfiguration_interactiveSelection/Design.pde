// Interactive Selection
// https://www.karlsims.com/papers/siggraph91.html

// The class for our Design, contains DNA sequence, fitness value, position on screen

// Fitness Function f(t) = t (where t is "time" mouse rolls over Design)

class Design {

  DNA dna;          // Design's DNA
  float fitness;    // How good is this Design?
  float x, y;       // Position on screen
  int wh = 120;      // Size of square enclosing Design
  boolean rolloverOn; // Are we rolling over this Design?

  Rectangle r;

  // Create a new Design
  Design(DNA dna_, float x_, float y_) {
    dna = dna_;
    x = x_; 
    y = y_;
    fitness = 1;
    // Using java.awt.Rectangle (see: http://java.sun.com/j2se/1.4.2/docs/api/java/awt/Rectangle.html)
    r = new Rectangle(int(x-wh/2), int(y-wh/2), int(wh), int(wh*2));
  }

  // Display the Design
  void display() {

    pushMatrix();
    translate(x, y);
    noStroke();

    // Draw the bounding box
    stroke(0.25);
    if (rolloverOn) fill(0, 0.25);
    else noFill();
    rectMode(CENTER);
    //rect(0, 0, wh, wh*2);
    
    popMatrix();

    // Display fitness value
    textAlign(CENTER);
    if (rolloverOn) fill(0);
    else fill(0.25);
    text(int(fitness), x, y+250);

    for (int i = 0; i < 3; i ++) {
      for (int j = 0; j < 6; j ++) {
        noStroke();
        fill(dna.genes[i*3*3+j*3+0], dna.genes[i*3*3+j*3+1], dna.genes[i*3*3+j*3+2]);
        rect(x-wh/3+wh/3*i, y-wh/3+wh/3*j, wh/3, wh/3);
      }
    }
  }

  float getFitness() {
    return fitness;
  }

  DNA getDNA() {
    return dna;
  }

  // Increment fitness if mouse is rolling over Design
  void rollover(int mx, int my) {
    if (r.contains(mx, my)) {
      rolloverOn = true;
      fitness += 0.25;
    } else {
      rolloverOn = false;
    }
  }
}
