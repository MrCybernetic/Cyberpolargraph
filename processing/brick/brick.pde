import processing.svg.*;


int tileWidth=7;
int mapX1, mapY1;
int nbW = 15;
int nbH = 10;

int[][] brickTypes={{1,1},{1,2},{2,1},{2,2},{1,3},{2,3},{3,1},{3,2},{1,4},{2,4},{4,1},{4,2}};




void setup() {
  size(900, 900);
  noLoop();
  beginRecord(SVG, "filename.svg");
  noFill();
  strokeWeight(1);
  stroke(0);
}

void draw() {
  for (int i=0; i<nbW;i++) {
    for (int j=0; j<nbH;j++) {
      pushMatrix();
      translate(j*tileWidth*12+50,i*tileWidth*8+50);
      int hz =round(random(11));
      drawBrick(brickTypes[hz][0],brickTypes[hz][1]);
      popMatrix();
    }
  }
  endRecord();
}


void iso(float x, float y, float h) {
   mapX1=round((x-y)*tileWidth/2.0);
   mapY1=round((x+y)*tileWidth/4.0);
  vertex(mapX1/*+width/2.0*/+3*tileWidth,  mapY1/*+height/3.0*/+h*tileWidth+1*tileWidth);
}

void isoEllipse(float x, float y) {
  mapX1=round((x-y)*tileWidth/2.0);
   mapY1=round((x+y)*tileWidth/4.0);
  ellipse( mapX1+3*tileWidth, mapY1+1*tileWidth-tileWidth/1.2, tileWidth, tileWidth/2.0);
  beginShape();
  iso(x-1.5,y-2.5,0.2);
  iso(x-1.5, y-2.5,0.5);
  endShape();
  beginShape();
  iso(x-2.5,y-1.5,0.2);
  iso(x-2.5, y-1.5,0.5);
  endShape();

}

void drawBrick(int w, int h) {
  beginShape();
  iso(0,2.5*w,0);
  iso(2.5*h,2.5*w,0);
  iso(2.5*h,0,0);
  iso(0,0,0);
  iso(0,2.5*w,0);
  iso(0,2.5*w,2);
  iso(2.5*h,2.5*w,2);
  iso(2.5*h,0,2);
  iso(2.5*h,0,0);
  endShape();
  beginShape();
  iso(2.5*h,2.5*w,0);
  iso(2.5*h, 2.5*w,2);
  endShape();
  for (int i=0; i<w;i++) {
    for (int j=0; j<h;j++) {
      isoEllipse((j+1)*2.5,(i+1)*2.5);
    }
  }

}
