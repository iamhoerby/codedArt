ArrayList<Circle> circles = new ArrayList();
int areaSize = 5; //Change size of chars here
String chars = " .:-=+*#%@";
void setup() {
    size(800,800);
}


void draw() {
    fill(#ffffff);
    rect(0,0,width,height);
    if (frameCount%80 == 0) {
        generateCircle();

    }
    int[][] pixel = new int[width/areaSize][height/areaSize];
    for (int i = 0; i < pixel.length; i++) {
        for (int j = 0; j < pixel[i].length; j++) {
            pixel[i][j] = 0; 
        }
    } 
    if (circles.size() != 0) {
        for (int i = 0; i < width/areaSize; i++) {
            for (int j = 0; j < height/areaSize; j++) {
                for (Circle circle : circles) {
                    if(checkPoint(i*areaSize,j*areaSize,circle)) {
                        pixel[i][j]++;
                        if (pixel[i][j] > 9) {
                            pixel[i][j] = 9;
                        }
                    }; 
                }
            }  
        }
    }
    
    for (int i = 0; i < pixel.length; i++) {
        for (int j = 0; j < pixel[i].length; j++) {
            fill(0,0,0);
            text(chars.charAt(pixel[i][j]),i*areaSize,j*areaSize); 
        }
    } 
    for (int i = 0; i < circles.size(); i++) {
        //circles.get(i).drawCircle();
        circles.get(i).enlarge();
    }
    deleteCircles();
}

void generateCircle() {
    int x = int(random(0,width));
    int y = int(random(0,height));
    circles.add(new Circle(x,y));
}
void deleteCircles() {
    for (int i = 0; i < circles.size(); i++) {
        if (circles.get(i).size > width*1.5) {
            circles.remove(i);
        }
    }
}
boolean checkPoint(int x, int y, Circle circle) {
    int dx = abs(x-circle.x);
    int dy = abs(y-circle.y);
    int r = circle.size;
    if (dx>r) {
        return false;
    }
    if (dy>r) {
        return false;
    } 
    if (dx + dy <= r) {
        return true;
    } 
    if (dx*dx + dy*dy <= r*r) {
        return true;
    } else {
        return false;
    }
}
class Circle {
    int x,y,size,speed;
    boolean exist;
    Circle(int posX, int posY) {
        x = posX;
        y = posY;
        size = 0;
        speed = int(random(0,10));
        exist = true;
    }
    void drawCircle() {
        fill(0,0,0,25);
        circle(x,y,size);
    }
    void enlarge() {
        if (exist) {
            size+=speed;
        }
    }
}
