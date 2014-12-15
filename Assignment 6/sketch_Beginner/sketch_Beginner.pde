void setup() {
  size(480, 480);
  stroke(255);
}

void draw() {
   background(192, 64, 83);
  if (mousePressed) {
    fill(175);
  } else {
    fill(100);
  }
  ellipse(mouseX, mouseY, 80, 80);
}

