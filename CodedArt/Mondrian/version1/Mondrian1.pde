int canvasSize = int(500);
// Input 
float stroke = 20;
float opacity = 0.5;
float fps = 1;

void setup() {
  size(500, 500);
  frameRate(fps);
}

void draw() {
  float size = random(stroke, canvasSize/2);
  float posX = random(0,canvasSize);
  float posY = random(0,canvasSize);
  
  // clear Canvas
  int opacityColor = int(255 * opacity);
  fill(255,255,255,opacityColor);
  noStroke();
  rect(0,0,1000,1000);
  stroke(0);
  
  rectMode(CENTER);
  
  //Horizontal Lines
  float linePos = random(0,canvasSize);
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(0,linePos,1000,linePos);
  
  linePos = random(0,canvasSize);
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(0,linePos,1000,linePos);
  
  //Vertical Lines
  linePos = random(0,canvasSize);
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(linePos,0,linePos,1000);
  
  linePos = random(0,canvasSize);
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(linePos,0,linePos,1000);
  
  //Random Color
  fill(random(0,255),random(0,255),random(0,255));
      
  strokeWeight(4);
  rect(posX, posY, size, size);
  
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(posX - size/2,0,posX - size/2,canvasSize);
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(0,posY- size/2,canvasSize,posY - size/2);
  
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(posX + size/2,0,posX + size/2,canvasSize);
  strokeWeight(random(stroke - 20 ,stroke + 20));
  line(0,posY + size/2,canvasSize,posY + size/2);
}
