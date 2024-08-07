int posX = 0; 
int posY = 0; 
int currentWidth = width;
int currentHeight = height; 
int tempHeight = 0; 
int tempWidth = 0; 
int horizontal = 0; 
int position = 0; 
int otherSide = 0; 
int frameCounter = 0; 

void setup() {
    size(800,800);
    frameRate(33);
    colorMode(HSB,359,60,60,100);
}

void draw() {
  posX = 0;
  posY = 0;
  currentWidth = width;
  currentHeight = height;
  stroke(0);
  strokeWeight(10);

  if (frameCount%33 == 0) {
    fill(0,0,60,100);
    rect(0,0,width,height); 
    splitRectangle(posX,posY,width,height); 
    frameCounter++; 
    if (frameCounter == 60) {
      frameCounter = 1; 
    } 
  } 
}

void chooseColor() {
  int colorTrue = int(random(0,10));
  int saturation = 60 - frameCounter;
  int brightness = 60 - frameCounter/2;
  if (colorTrue%2 == 0) {
    int i = int(random(0,4));
    switch(i) {
      case 0: // black
        fill(0,0,0,100);
        break;
      case 1: // red
        fill(359,saturation,brightness,100);
        break;
      case 2: // yellow 
        fill(60,saturation,brightness,100);
        break;
      case 3: // blue
        fill(239,saturation,brightness,100);
        break;
      default: 
        fill(0,0,60,100);
        break;
    }
  } else {
    fill(0,0,60,100);
  }
}

void drawRect(int x, int y, int w, int h) {
  chooseColor(); 
  rect(x,y,w,h);
}
  
void splitRectangle(int x, int y, int w, int h) {
  if (w >= width/random(5,10) && h >= height/random(5,10)) {
    horizontal = int(random(0,10)); 
    position = int(random(0,10));
    int newHeight = h;
    int newWidth = w;
    int newPosX = x;
    int newPosY = y;
    if (horizontal%2 == 0) {
      newHeight = h/int(random(2,4));
      newWidth = w;
      if (position%2 == 0) {
        newPosX = x;
        newPosY = y + newHeight;
      } else {
        newPosX = x;
        newPosY = y; 
      }
    } else {
      newHeight = h; 
      newWidth = w/int(random(2,4)); 
      if (position%2 == 0) {
        newPosX = x + newWidth;
        newPosY = y;
      } else {
        newPosX = x;
        newPosY = y; 
      }
    }
    // Draw and Split 
    drawRect(newPosX,newPosY,newWidth,newHeight);
    splitRectangle(newPosX,newPosY,newWidth,newHeight); 
    
    // Decide if other Side of rectancle should split as well 
    otherSide = int(random(0,10));
    if (otherSide%2 == 0) {
      horizontal = int(random(0,10));

      if (horizontal%2 == 0) {
      newHeight = h/int(random(2,4));
      newWidth = w;
        if (!(position%2 == 0)) {
          newPosX = x;
          newPosY = y + newHeight;
        } else {
          newPosX = x;
          newPosY = y; 
        }
      } else {
        newHeight = h; 
        newWidth = w/int(random(2,4)); 
        if (!(position%2 == 0)) {
          newPosX = x + newWidth;
          newPosY = y;
        } else {
          newPosX = x;
          newPosY = y; 
        }
      }
      // Draw and Split 
      drawRect(newPosX,newPosY,newWidth,newHeight);
      splitRectangle(newPosX,newPosY,newWidth,newHeight);   
    }
  } else {
    return;
  }
}
