#include "Wheels.h"
#include "PinChangeInterrupt.h"

Wheels w;

void setup() {
  w.attach(5,6,11,10,9,3);
  w.setSpeed(200);

  //w.forward();
  Serial.begin(9600);

  pinMode(INTINPUT0, INPUT);
  pinMode(INTINPUT1, INPUT);

 attachPCINT(digitalPinToPCINT(INTINPUT0), increment, CHANGE);
 attachPCINT(digitalPinToPCINT(INTINPUT1), increment, CHANGE);
}

void loop() {
  Serial.print(cnt0);
  Serial.print(" ");
  Serial.println(cnt1);
  delay(250);
}
