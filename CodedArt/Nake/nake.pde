PVector plotterHead, last, first;
PVector direction;

// Possible UI 
int lineLength = 20; // How long should the steps in the line be? 
int rotationRate = 10; // How often should the line turn? (0-100)
int angleDistortion =45; // How much degrees should the angles of the line variate? (0-90)
int lineWeight = 4; // How thick should the lines be? 
boolean isEaseMode = false; // True: line disappears False: line stays visible
boolean isColorMode = true; // Color or Black and White
int speed = 50; // Speed in %
int canvasAngle = 45; // Rotate the Canvas

boolean isAlternativMode = false; // Set to true for alternativ mode
boolean seeColorDistribution = false; // Set to true to see how the colors are set
// End UI

void setup() {
  size(800, 800);
  smooth();
  background(0, 0, 0);
  colorMode(RGB,width,width,width,width);
  stroke(0, 100);
  strokeWeight(lineWeight);
  frameRate(30 * (speed*0.01));

  plotterHead = new PVector(random(800), random(800));
  
  first = plotterHead.copy();
  last = plotterHead.copy();
  direction = PVector.fromAngle(radians(canvasAngle));
  chooseColor(plotterHead);
}

void draw() {
  if (seeColorDistribution) {
    plotColors(); 
  } else {
    
    plotterHead = PVector.add(plotterHead, PVector.mult(direction,lineLength));
    if (!isAlternativMode) {
       line(plotterHead.x, plotterHead.y, last.x, last.y);
    } else {
       line(plotterHead.x, plotterHead.y, first.x, first.y);
    }
    last = plotterHead.copy();
    
    //Set direction 
    if (random(100/rotationRate)<=1 || (plotterHead.x>=width || plotterHead.x<=0 ||plotterHead.y>=height || plotterHead.y<=0)) {
      direction.rotate(random(HALF_PI-radians(angleDistortion),HALF_PI+radians(angleDistortion)));
      chooseColor(plotterHead);
    } else if(random(100/rotationRate) <= 1){
      direction.rotate(-random(HALF_PI-radians(angleDistortion/2),HALF_PI+radians(angleDistortion/2))); 
      chooseColor(plotterHead);
    }
  }
  if (isEaseMode) {
      easeOut();
  }
 

}

void chooseColor(PVector plotterHead) {
  if (isColorMode) {
    float alpha=width - abs((plotterHead.x - plotterHead.y));
    float red = abs((plotterHead.x - plotterHead.y));
    float green = 0;
    float blue = abs(plotterHead.y); 
    strokeWeight(lineWeight);
    stroke(red,green,blue,alpha);
  } else {
    stroke(255,255,255,800);
  }
  
}

void plotColors() {
 plotterHead = new PVector(0,0);
 for (int i = 0; i < (width/4)*(width/4); i++) {
    plotterHead.x = plotterHead.x + 4;
  if (plotterHead.x >= width) {
    plotterHead.y = plotterHead.y + 4;
    plotterHead.x = 0;
    last = plotterHead.copy();
  } else {
    chooseColor(plotterHead);
    line( last.x, last.y,plotterHead.x, plotterHead.y);
    last = plotterHead.copy();
  }
  }
}

void easeOut() {
  fill(0,0,0,50);
  rect(-10,-10,width+20,height+20);
}
