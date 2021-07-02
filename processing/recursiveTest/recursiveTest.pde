import processing.svg.*;

int Col=10,Row=18,nbreGen=15 ;
float size=50, space=5;

void setup() {
   size(625, 1025);
   surface.setLocation(2000,-600);
   beginRecord(SVG, "filename.svg");
   noFill();
   noLoop();
}

void draw() {
   
   rect(space/2.0,space/2.0,Col*(size+space),Row*(size+space));
   for(int x=0 ; x<Col ; x++) {
     for(int y=0 ; y<Row ; y++) {
       float direction = random(TWO_PI);
       float force = 2.0+random(5);
       cyberSquare(space+x*(size+space),space+y*(size+space),size,size,direction, force,1,nbreGen);
     }
   }
   endRecord();
}

void cyberSquare(float x, float y, float w, float h, float dir, float frc, int gen, int genMax) {
   if(gen==genMax) {
      
   } else {
      cybr c= new cybr(x,y,w,h);
      c.drawC();
      
      
      float newW = w*(1-(gen/(float)genMax));
      float newH = h*(1-(gen/(float)genMax));
      float newX = x+(w*(gen/(float)genMax)/2.0)+(w*(gen/(float)genMax)/frc)*cos(dir);
      float newY = y+(h*(gen/(float)genMax)/2.0)+(h*(gen/(float)genMax)/frc)*sin(dir);
      println(newW);
      cyberSquare(newX,newY,newW,newH,dir,frc,gen+1, genMax);
   }
}

class cybr {
   float x,y,w,h;
   cybr(float xp, float yp, float wp, float hp) {
      x=xp;
      y=yp;
      w=wp;
      h=hp;
   }
   void drawC() {
     if(w>=5)rect(x,y,w,h);
   }
}
