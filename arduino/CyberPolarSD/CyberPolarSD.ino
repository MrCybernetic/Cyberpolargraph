/*                                                            
 ,-----.         ,--.                               ,--.                
'  .--./,--. ,--.|  |-.  ,---. ,--.--. ,---.  ,---. |  | ,--,--.,--.--. 
|  |     \  '  / | .-. '| .-. :|  .--'| .-. || .-. ||  |' ,-.  ||  .--' 
'  '--'\  \   '  | `-' |\   --.|  |   | '-' '' '-' '|  |\ '-'  ||  |    
 `-----'.-'  /    `---'  `----'`--'   |  |-'  `---' `--' `--`--'`--'    
        `---'                         `--'                              

  - 15/05/2021 : Birth
stipple l1290
servo 5 : pen up
servo 50: pen down
X = Right
Y = Left
Dir High = CW
Button high default
*/
#include <Servo.h>
#include <SPI.h>
#include <SD.h>

Servo myservo; 

// defines pins numbers //
const int stepX = 2;
const int dirX = 5;
const int stepY = 3;
const int dirY = 6;
const int enPin = 8;
const int buttonPin = 9;
//SD
const int chipSelect = 10;
File dataFile;
const char* buffer;

// defines machine settings //
const float PulsesPerMM = 4.44;
const float MachineWidth = 648.0;
int timePulse = 5000;
const float lengthZeroRight = 400.0;  // distance between the right pulley and the center of the rode
const float lengthZeroLeft = 400.0;   // distance between the left pulley and the center of the rode

//Process variables
int pulsesMotorRightDone = 0;
int pulsesMotorLeftDone = 0;
bool Rplus;
bool Lplus;

void setup() {
  myservo.attach(A3); 
  penup();

  Serial.begin(115200);
  Serial.println("Cyberpolar initialising...");
  
  // Pins init
  pinMode(stepX, OUTPUT);
  pinMode(dirX, OUTPUT);
  pinMode(stepY, OUTPUT);
  pinMode(dirY, OUTPUT);
  pinMode(enPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);

  // Enable drivers
  digitalWrite(enPin, LOW);

  // Zero Machine
  pulsesMotorRightDone = round(lengthZeroRight * PulsesPerMM);
  pulsesMotorLeftDone = round(lengthZeroLeft * PulsesPerMM);
  Serial.println("Setup done, File Open. Let's go in LOOP!");

  while (digitalRead(buttonPin) == HIGH)   delay(100);
  Serial.print("Initializing SD card...");
  // see if the card is present and can be initialized:
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    while (1);
  }
  Serial.println("card initialized.");

  // open the file. note that only one file can be open at a time,
  // so you have to close this one before opening another.
  dataFile = SD.open("ToPlot/", FILE_READ).openNextFile(O_RDONLY);
  dataFile.seek(0);
  if (dataFile) {
    while (dataFile.available()) {
      String gCodeLine ="";
      char myChar='<';
      while ((myChar != '\n') && (myChar != -1)) {
        if (myChar!='<') gCodeLine+=myChar;
        myChar= dataFile.read();
      }
      Serial.println((myChar == -1));
      if (gCodeLine.indexOf("G10")!=-1) penup();
      if (gCodeLine.indexOf("G11")!=-1) pendown();
      if ((gCodeLine.indexOf("G01")!=-1) || (gCodeLine.indexOf("G00")!=-1)) {
        if ((gCodeLine.indexOf("X")!=-1) && (gCodeLine.indexOf("Y")!=-1)) {
          goTo((gCodeLine.substring(gCodeLine.indexOf("X")+1, gCodeLine.indexOf("Y")-1).toFloat()),(gCodeLine.substring(gCodeLine.indexOf("Y")+1, gCodeLine.indexOf("Z")-1).toFloat()));
        } else {
          //Serial.println("------G01 or G00 without X or Y");
        }
      }
    }
    Serial.println("------dataFile Closed");
    dataFile.close();
  } else {
    Serial.println("error opening file");
  }
  Serial.println("Plotting Done.");
}

void loop() {
//Serial.println("looping");
}
