#include <Servo.h>
#include "Wheels.h"
// piny dla sonaru (HC-SR04)
#define TRIG A4
#define ECHO A5

// pin kontroli serwo (musi być PWM)
#define SERVO 6

Servo serwo;
Wheels w;

int volatile dir = 0; // 1 goright -1 goleft
unsigned int volatile distance = 100;

void setup() {
  
  w.attach(5,7,11,10,9,3); 
  w.setSpeed(255);
  w.forward();
  pinMode(TRIG, OUTPUT);    // TRIG startuje sonar
  pinMode(ECHO, INPUT);     // ECHO odbiera powracający impuls

  Serial.begin(9600);

  serwo.attach(SERVO);

/* rozejrzyj się w zakresie od 0 stopni (patrz na jedną burtę)
 *  do 180 stopni (patrz na prawą burtę). Wydrukuj na konsoli
 *  kierunek patrzenia i najbliżej widziany obiekt (pojedynczy pomiar)
 *
  for(byte angle = 0; angle < 180; angle+= 20) {
    lookAndTellDistance(angle);
    delay(500);
  }
  
/* patrz przed siebie /
  serwo.write(90);
*/
}

void loop() { 
  for(byte angle = 30; angle < 140; angle+= 20) {
    lookAndTellDistance(angle);
    if(distance < 50){
      check(angle);
      if(distance < 30){
        w.back();
        while(distance < 55){
        lookAndTellDistance(angle);
        }
        if(dir == -1){
          dir = 1;
        }else{
          dir = -1;
        }
      }
      if(dir == -1){
        w.stopRight();
      }else{
        w.stopLeft();
      }
      while(distance < 100){
        lookAndTellDistance(angle);
      }
    }else{
      w.forward();
    }
  }
  
/* patrz przed siebie */
  //serwo.write(90);

  /* nic nie rób */ }

void lookAndTellDistance(byte angle) {
  
  unsigned long tot;      // czas powrotu (time-of-travel)
  

  Serial.print("Patrzę w kącie ");
  Serial.print(angle);
  serwo.write(angle);
  
/* uruchamia sonar (puls 10 ms na `TRIGGER')
 * oczekuje na powrotny sygnał i aktualizuje
 */
  digitalWrite(TRIG, HIGH);
  delay(5);
  digitalWrite(TRIG, LOW);
  tot = pulseIn(ECHO, HIGH);

/* prędkość dźwięku = 340m/s => 1 cm w 29 mikrosekund
 * droga tam i z powrotem, zatem:
 */
  distance = tot/58;
  
  Serial.print(": widzę coś w odległości ");
  Serial.println(distance);
}

void check(byte angle){
  if(angle >= 90){
    dir = -1;
  }else{
    dir = 1;
  }
}
