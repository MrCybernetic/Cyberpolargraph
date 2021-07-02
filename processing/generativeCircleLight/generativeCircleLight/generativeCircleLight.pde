import processing.svg.*;

int nbrH=25;
int nbrW=28;
int nbrSeg=30;
int diameter;
PVector pStart,pEnd,pLight;
float angle;
float percentageLight;
float a=0,b=0;

void setup() {
  size(800,800);  
  diameter=round(0.7*width);
  surface.setLocation(1950,-500);
    noFill();
    stroke(0);
    strokeWeight(1);
    noLoop();
    background(255);
    frameRate(24);
    
      pLight= new PVector();
  pLight.x=random(-diameter/2.0,diameter/2.0);
  pLight.y=random(-sqrt(sq(diameter/2.0)-sq(pLight.x)) , sqrt(sq(diameter/2.0)-sq(pLight.x)));
beginRecord(SVG, "CircleLight.svg");
}

void draw() {
  /*a+=0.01;
  if (a>=2*PI) a=0;
  b+=0.012;
  if (b>=2*PI) b=0;*/
  nbrSeg = /*round(25+55*abs(cos(a)));*/round(random(5,25));
  nbrH= /*round(10+30*abs(cos(b)));*/round(random(10,40));
  nbrW= /*round(10+30*abs(cos(b)));*/round(random(10,40));
  //angle=a/10.0;
  angle=random(2*PI);
  //background(255);
  pushMatrix();
  translate(width/2.0,height/2.0);
  rotate(angle);

  for (int i=0;i<=nbrH;i++){
    for (int s=0;s<nbrSeg-1;s++) { //horizontal
      pStart=new PVector(-diameter/2.0+s*diameter/(float)nbrSeg,-diameter/2.0+i*diameter/(float)nbrH);
      pEnd=new PVector(-diameter/2.0+(s+1)*diameter/(float)nbrSeg,-diameter/2.0+i*diameter/(float)nbrH);
      if ((pStart.mag()<diameter/2.0) && (pEnd.mag()<diameter/2.0)){
          percentageLight=pLight.dist(pStart)/(diameter/2.0);
        int pix=0; 
        for (int j=0;j<=pStart.dist(pEnd);j++){
          if (j<(pStart.dist(pEnd)*percentageLight)) {
          pix++;
          }
        }
        if(pix>1) {
          beginShape();
          vertex(pStart.x,pStart.y);    
          vertex(pStart.x+pix,pStart.y);
          endShape();
        }
      }
    }
  }
  for (int i=0;i<=nbrW;i++){
    for (int s=0;s<nbrSeg;s++) { //Vertical
      pStart=new PVector(-diameter/2.0+i*diameter/(float)nbrW,-diameter/2.0+(s)*diameter/(float)nbrSeg);
      pEnd=new PVector(-diameter/2.0+i*diameter/(float)nbrW,-diameter/2.0+(s+1)*diameter/(float)nbrSeg);
      if ((pStart.mag()<diameter/2.0) && (pEnd.mag()<diameter/2.0)){
          percentageLight=pLight.dist(pStart)/(diameter/2.0);
        int pix=0; 
        for (int j=0;j<=pStart.dist(pEnd);j++){
          if (j<(pStart.dist(pEnd)*percentageLight)) {
            pix++;
          }
        }
        if(pix>1) {
          beginShape();
          vertex(pStart.x,pStart.y);    
          vertex(pStart.x,pStart.y+pix);
          endShape();
        }
      }
    }
  }
  popMatrix();
  endRecord();
}
