String[] sentences = new String[4];

void setup() {
  size(600, 100);
  sentences[0] = "Such a lovely place";
  sentences[1] = "Such a lovely face";
  sentences[2] = "There's plenty of rooms at the Hotel California";
  sentences[3] = "Any time of year";
}

void draw() {
  background(255);
  fill(0);
  float y = 10;
  for (int  i = 0; i < sentences.length; i ++) {
    float w = sentences[i].length()*10;
    rect(0, y, w, 18);
    y = y + 20;
  }
}
