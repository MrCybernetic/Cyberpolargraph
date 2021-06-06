void goTo(float xparm, float yparam) {
  /*
  *xparam and y param in mms
   * (x-x0)²+(y-y0)²=r0²
   * (x-x1)²+(y-y1)²=r1²
   * y0 = y1 = 0
   * x1=x0=L/2
   */
  int pulsesMotorRight = round(sqrt(pow(xparm - (MachineWidth / 2.0), 2) + pow(yparam, 2)) * PulsesPerMM);
  int pulsesMotorLeft = round(sqrt(pow(xparm - (-MachineWidth / 2.0), 2) + pow(yparam, 2)) * PulsesPerMM);

  pulsesMotorRight-=pulsesMotorRightDone;
  pulsesMotorLeft-=pulsesMotorLeftDone;

  int biggest = max(abs(pulsesMotorRight), abs(pulsesMotorLeft));
  float mem = 1.0;

  // Set motors direction
  if (pulsesMotorRight > 0) {
    digitalWrite(dirX, LOW);
    Rplus = true;
  } else {
    digitalWrite(dirX, HIGH);
    Rplus = false;
  }
  // Motor Left Inverted
  if (pulsesMotorLeft > 0) {
    digitalWrite(dirY, HIGH);
    Lplus = true;
  } else {
    digitalWrite(dirY, LOW);
    Lplus = false;
  }

  for (int x = 0; x < biggest; x++) {
    bool bstepX = false;
    bool bstepY = false;
    if (biggest == abs(pulsesMotorRight) || x == 0) {
      bstepX = true;
    } else if ((mem / float(x)) <= (abs((float)pulsesMotorRight) / (abs((float)pulsesMotorLeft)))) {
      bstepX = true;
      mem++;
    }
    if (biggest == abs(pulsesMotorLeft) || x == 0) {
      bstepY = true;
    } else if ((mem / float(x)) <= (abs((float)pulsesMotorLeft) / (abs((float)pulsesMotorRight)))) {
      bstepY = true;
      mem++;
    }
    stepper(bstepX, bstepY, Rplus, Lplus);
  }
}

void stepper(bool X, bool Y, bool Rplusparam, bool Lplusparam) {
  if (X) digitalWrite(stepX, HIGH);
  if (Y) digitalWrite(stepY, HIGH);
  delayMicroseconds(timePulse);
  if (X) digitalWrite(stepX, LOW);
  if (Y) digitalWrite(stepY, LOW);
  delayMicroseconds(timePulse);
  if (X && Rplusparam) pulsesMotorRightDone ++;
  if (X && !Rplusparam) pulsesMotorRightDone --;
  if (Y && Lplusparam) pulsesMotorLeftDone ++;
  if (Y && !Lplusparam) pulsesMotorLeftDone --;
}

void pendown() {
  //Serial.println("------pendown");
  delay(80);
  myservo.write(90);
  timePulse = 5000;
  delay(450);
}

void penup() {
  //Serial.println("------pendup");
  myservo.write(10);
  timePulse = 2000;
  delay(450);
}