#include <Arduino.h>


#ifndef Wheels_h
#define Wheels_h

#define INTINPUT0 A0
#define INTINPUT1 A1

extern volatile int cnt0, cnt1, d;

//void increment();

class Wheels {
    public: 
        Wheels();
        void attachRight(int pinForward, int pinBack, int pinSpeed);
        void attachLeft(int pinForward, int pinBack, int pinSpeed);
        void attach(int pinRightForward, int pinRightBack, int pinRightSpeed,
                    int pinLeftForward, int pinLeftBack, int pinLeftSpeed);
        void forward();
        void forwardLeft();
        void forwardRight();
        void back();
        void backLeft();
        void backRight();
        void stop();
        void stopLeft();
        void stopRight();
        void setSpeed(uint8_t);
        void setSpeedRight(uint8_t);
        void setSpeedLeft(uint8_t);
        
        void go(int);
        
        void goForward(int);
        void goForwardb(int);
      //  void turn(int);

    private: 
        int pinsRight[3];
        int pinsLeft[3];
};



#endif
