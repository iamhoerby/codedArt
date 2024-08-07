PImage source;
int area = 6; //pixel block size
String chars = " .:-=+*#%@";

void setup () {
  size(1920,1080);
  noStroke();
  colorMode(HSB);
  background(#ffffff);
  /*
  load image file from sketch folder
  (directly in the same folder as the ".pde" file or in the "data" subfolder)
  */
  source = loadImage("welle.jpg");

  /*
  iterate over blocks of the image
  the blocksize (=area) defines the amount of pixelation
  */
  char lastChar = 0;
  chars = new StringBuffer(chars).reverse().toString();
  for (int y=0; y<source.height; y+=area) {
    for (int x=0; x<source.width; x+=area) {
      char thisChar = getChar(x, y, area, area, source);
      fill(getAverageColor(x,y,area,area,source));
      fill(0);
      if (thisChar == lastChar) {
        textSize(area*2);
        text(thisChar,x,y);
        x+=area;
      } else { 
        textSize(area);
        text(thisChar,x,y);
      }
      lastChar = thisChar;
    }
  }
  //save("welleASCII1.jpg");
  area=area/2;
  for (int y=0; y<source.height; y+=area) {
    for (int x=0; x<source.width; x+=area) {
      char thisChar = getChar(x, y, area, area, source);
      //fill(getAverageColor(x,y,area,area,source));
      fill(0);
      if (thisChar == getChar(x+area, y+area, area, area, source)) {
        textSize(area*2);
        text(thisChar,x,y);
        x+=area;
      } else { 
        textSize(area);
        text(thisChar,x,y);
      }
      lastChar = thisChar;
    }
  }
  save("welleASCII2.jpg");
}

color getAverageColor ( int x, int y, int w, int h, PImage img) {
  // calculate the average r,g,b value of a block within the image img
  float hue = 0;
  float s = 0;
  float b = 0;
  // iterate over all pixels within the block of the size w*h
  // since pixels are stored in a one dimensional array the index has to be calculated
  for (int i=0; i<w*h; i++) {
    // calculate index
    int index = x+(i%w)+y*img.width+(img.width*(i/w));
    if (index<img.pixels.length) {
      // increment by value of each color channel
      hue += hue(img.pixels[index]);
      s += saturation(img.pixels[index]);
      b += brightness(img.pixels[index]);
    }
  }
  // calcualte color from channel average
  return color(hue/(w*h), s/(w*h), b/(w*h));
}
color getBrighterAverageColor ( int x, int y, int w, int h, PImage img) {
  // calculate the average r,g,b value of a block within the image img
  float hue = 0;
  float s = 0;
  float b = 0;
  // iterate over all pixels within the block of the size w*h
  // since pixels are stored in a one dimensional array the index has to be calculated
  for (int i=0; i<w*h; i++) {
    // calculate index
    int index = x+(i%w)+y*img.width+(img.width*(i/w));
    if (index<img.pixels.length) {
      // increment by value of each color channel
      hue += hue(img.pixels[index]);
      s += saturation(img.pixels[index]);
      b += brightness(img.pixels[index]);
    }
  }
  // calcualte color from channel average
  return color(hue/(w*h), s/(w*h), b/(w*h) + 40);
}
char getChar(int x, int y, int w, int h, PImage img) {
  float b = 0;
  for (int i=0; i<w*h; i++) {
    // calculate index
    int index = x+(i%w)+y*img.width+(img.width*(i/w));
    if (index<img.pixels.length) {
      // increment by value of each color channel
      b += brightness(img.pixels[index]);
    }
  }
  b = b/(w*h);
  int index = int(b/255 * 9);
  textSize(index+2);
  //text(index,x,y);
  return chars.charAt(index);
}
