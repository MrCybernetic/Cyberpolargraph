import controlP5.*;
import processing.svg.*;

/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */
ControlP5 cp5;

PImage img;  // Declare variable "a" of type PImage
PImage workImg;  // Declare variable "a" of type PImage
int imgW, imgH;


int nbPixelsX=50;
int nbPixelsY=50;
int tileWidth=17;

int mapX1, mapY1;
float b1;

int seedX, seedY;

void setup() {
  seedX=round(random(88888));
  seedY=round(random(88888));
  size(900, 900);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("circles.png");  // Load the image into the program  
  noLoop();
  beginRecord(SVG, "filename.svg");
  noFill();
  strokeWeight(1);
  stroke(0);
}

void draw() {
   //loadImg();   
   for (int x=1 ; x<nbPixelsX-1 ; x++){
     beginShape();
     for (int y=0 ; y<nbPixelsY ; y++){
       mapX1=round((x-y)*tileWidth/2.0);
       mapY1=round((x+y)*tileWidth/4.0);
       //b1=brightness(workImg.get(x*(imgW/nbPixelsX),y*(imgH/nbPixelsY)));
       b1=noise(x*0.25+seedX,y*0.25+seedY)*255;
       //y : 0 -> nbPixelsY
       // -nbPixelsY/2 -> nbPixelsY/2
  
       println(((y*y/1000)));
      curveVertex(mapX1+width/2,  mapY1+height/3+b1*0.2);
     }
     endShape();
   }
   for (int y=1 ; y<nbPixelsY-1 ; y++){
   
     beginShape();
       for (int x=0 ; x<nbPixelsX ; x++){
       mapX1=round((x-y)*tileWidth/2.0);
       mapY1=round((x+y)*tileWidth/4.0);
       //b1=brightness(workImg.get(x*(imgW/nbPixelsX),y*(imgH/nbPixelsY)));
       b1=noise(x*0.25+seedX,y*0.25+seedY)*255;
      
      curveVertex(mapX1+width/2,  mapY1+height/3+b1*0.2);
     }
     endShape();
   }
  endRecord();
}

void loadImg() {
  workImg = img.get();
  imgW = workImg.width;
  imgH = workImg.height;
}

//cos(x)*(1/(10+x*x))
