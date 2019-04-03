#include <Arduino.h>

#include "Wheels.h"

//
//#define SET_MOVEMENT(side,f,b) ( digitalWrite( side[0], f ) ); digitalWrite( side[1], b ) )

#define SET_MOVEMENT(side,f,b) digitalWrite( side[0], f);\
                               digitalWrite( side[1], b)
//#define HIGH 1
//#define LOW 0

//#define SET_MOVEMENT(s,f,b) delay(10);
volatile int cnt0, cnt1, d;

Wheels::Wheels() 
{ 
  cnt0 = 0;
  cnt1 = 0;
  d = 0;
}

void Wheels::attachRight(int pF, int pB, int pS)
{
    pinMode(pF, OUTPUT);
    pinMode(pB, OUTPUT);
    pinMode(pS, OUTPUT);
    this->pinsRight[0] = pF;
    this->pinsRight[1] = pB;
    this->pinsRight[2] = pS;
}


void Wheels::attachLeft(int pF, int pB, int pS)
{
    pinMode(pF, OUTPUT);
    pinMode(pB, OUTPUT);
    pinMode(pS, OUTPUT);
    this->pinsLeft[0] = pF;
    this->pinsLeft[1] = pB;
    this->pinsLeft[2] = pS;
}

void Wheels::setSpeedRight(uint8_t s)
{
    analogWrite(this->pinsRight[2], s);
}

void Wheels::setSpeedLeft(uint8_t s)
{
    analogWrite(this->pinsLeft[2], s);
}

void Wheels::setSpeed(uint8_t s)
{
    setSpeedLeft(s);
    setSpeedRight(s);
}

void Wheels::attach(int pRF, int pRB, int pRS, int pLF, int pLB, int pLS)
{
    this->attachRight(pRF, pRB, pRS);
    this->attachLeft(pLF, pLB, pLS);
}

void Wheels::forwardLeft() 
{
    SET_MOVEMENT(pinsLeft, HIGH, LOW);
}

void Wheels::forwardRight() 
{
    SET_MOVEMENT(pinsRight, HIGH, LOW);
}

void Wheels::backLeft()
{
    SET_MOVEMENT(pinsLeft, LOW, HIGH);
}

void Wheels::backRight()
{
    SET_MOVEMENT(pinsRight, LOW, HIGH);
}

void Wheels::forward()
{
    this->forwardLeft();
    this->forwardRight();
}

void Wheels::back()
{
    this->backLeft();
    this->backRight();
}

void Wheels::stopLeft()
{
    SET_MOVEMENT(pinsLeft, LOW, LOW);
}

void Wheels::stopRight()
{
    SET_MOVEMENT(pinsRight, LOW, LOW);
}

void Wheels::stop()
{
    this->stopLeft();
    this->stopRight();
}


void Wheels::goForward(int cm){
  this->forward();
  cnt0 = 0;
  cnt1 = 0;
  double distance = cm / 0.70;
  d = (int) distance;
}


void Wheels::goForwardb(int ob){
  this->forward();
  cnt0 = 0;
  cnt1 = 0;
  d = ob * 40;
}

void Wheels::go(int dis){
  if(dis > 105){
    this->forward();
    if(dis > 200){
      this->setSpeed(255);
    }else{
      int i = (155*(dis-105))/95 + 100;
      Serial.println(i);
      this->setSpeed(i);
    }
  }else if(dis < 95){
    this->back();
    if(dis < 10){
      this->setSpeed(255);
    }else{
      int j = (155*(95 - dis))/95 + 100;
      this->setSpeed(j);
      Serial.println(j);
    }
  }else{
    this->stop();
  }
}

/*
void Wheels::turn(int dir){
  if(dir)
  
}

/*
void Wheels::goLeft(){
  this->forwardRight();
  delay()
  cnt1 = 0;
  d = ob * 40;
}
*/
