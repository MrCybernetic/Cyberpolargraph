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
int imgW, imgH, maxDim, nbPixels=40, minDim;
float ratioSmallImg,ratioResize;
PVector p1 = new PVector(10,10);



void setup() {
  size(900, 900);
 /* cp5 = new ControlP5(this);
    cp5.addSlider("sliderAmp")
     .setPosition(50,600)
     .setSize(200,20)
     .setRange(0,20)
     .setValue(gAmp)
     .setSliderMode(Slider.FLEXIBLE)
     ;
     cp5 = new ControlP5(this);
    cp5.addSlider("sliderFreq")
     .setPosition(50,630)
     .setSize(200,20)
     .setRange(0,20)
     .setValue(gFreq)
     .setSliderMode(Slider.FLEXIBLE)
     ;
     cp5.addSlider("sliderQuad")
     .setPosition(50,660)
     .setSize(200,20)
     .setRange(1,256)
     .setValue(SpiralQuadran)
     .setSliderMode(Slider.FLEXIBLE)
     ;*/
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("Marilyn.jpg");  // Load the image into the program  
  noLoop();
  beginRecord(SVG, "filename.svg");
  noFill();
}

void draw() {
   loadImg();
   noFill();
   strokeWeight(3);
   stroke(0,255,255,150);
   drawCirclesCyan();
   stroke(255,0,255,150);
   drawCirclesMagenta();
   stroke(255,255,0,150);
   drawCirclesYellow();
  endRecord();
}

void loadImg() {
    imgW = img.width;
   imgH = img.height;
   maxDim = max(imgW, imgH);
   ratioSmallImg = nbPixels/((float)(maxDim));
  
    workImg = img.get();
    workImg.resize(round(img.width*ratioSmallImg), round(img.height*ratioSmallImg));
    //image(workImg,0,0);
    imgW = workImg.width;
   imgH = workImg.height;
    maxDim = max(imgW, imgH);
    ratioResize=800/((float)maxDim);
}

void drawCirclesMagenta(){
  int magenta;
  for (int x=0; x<=workImg.width-1;x++){
    for (int y=0; y<=workImg.height-1;y++){
      magenta = 255-(int)green((workImg.get(x,y)));
      circle(x*ratioResize+50,y*ratioResize+50,(int)((magenta/255.0)*(800/nbPixels)));
    }
 }
}

void drawCirclesYellow(){
  int yellow;
  for (int x=0; x<=workImg.width-1;x++){
    for (int y=0; y<=workImg.height-1;y++){
      yellow = 255-(int)blue((workImg.get(x,y)));
      circle(x*ratioResize+50,y*ratioResize+50,(int)((yellow/255.0)*(800/nbPixels)));
    }
 }
}

void drawCirclesCyan(){
  int cyan;
  for (int x=0; x<=workImg.width-1;x++){
    for (int y=0; y<=workImg.height-1;y++){
      cyan = 255-(int)red((workImg.get(x,y)));
      circle(x*ratioResize+50,y*ratioResize+50,(int)((cyan/255.0)*(800/nbPixels)));
    }
 }
}

/*void sliderAmp(int Amplitude) {
  gAmp = Amplitude;
  //value = inputProgramLimitSet;

}

void sliderFreq(int Freq) {
  gFreq = Freq;
  //value = inputProgramLimitSet;

}
void sliderQuad(int quadSize) {
  SpiralQuadran = quadSize;
}*/
