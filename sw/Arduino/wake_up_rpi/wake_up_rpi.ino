// Date and time functions using a DS1307 RTC connected via I2C and Wire lib

#include <Wire.h>
#include "RTClib.h"
//#include <SimpleList.h>

RTC_DS1307 rtc;

int wakeUpHours[13]={6,7,8,9,10,11,12,13,14,15,16,17,18};
int wakeUpMinutes[2]={00,30};

// constants won't change. Used here to set a pin number :
const int ledPin =  2;      // the number of the LED pin
int rpiStatus = 0;   // for incoming serial data

void setup () {
  Serial.begin(9600);
#ifdef AVR
  Wire.begin();
#else
  Wire1.begin(); // Shield I2C pins connect to alt I2C bus on Arduino Due
#endif
  rtc.begin();

  if (! rtc.isrunning()) {
    Serial.println("RTC is NOT running!");
    // following line sets the RTC to the date & time this sketch was compiled
    //rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
    // This line sets the RTC with an explicit date & time, for example to set
    // January 21, 2014 at 3am you would call:
    //rtc.adjust(DateTime(2015, 6, 16, 17, 27, 0));
  }
  
  // set the digital pin as output:
  pinMode(ledPin, OUTPUT);        
}

void loop () 
{
  DateTime now = rtc.now();
  // send data only when you receive data:
  if (Serial.available() > 0) 
  {
    // read the incoming byte:
    rpiStatus = Serial.read();
  
    // 1==Starting up... TRPI asks for date-time
    if(rpiStatus == '1')
    {
      Serial.print(now.year(), DEC);
      Serial.print('-');
      Serial.print(now.month(), DEC);
      Serial.print('-');
      Serial.print(now.day(), DEC);
      Serial.print(' ');
      Serial.print(now.hour(), DEC);
      Serial.print(':');
      Serial.print(now.minute(), DEC);
      Serial.print(':');
      Serial.print(now.second(), DEC);
      //Serial.print('B');
      Serial.println();
    }
    // 2==taking pictures ... RPI is taking pictures 
    else if(rpiStatus == '2')
    {
      Serial.print('2');
    }  
    // 3==transfering pictures... RPI is tranfering pictures to Stephanie
    else if(rpiStatus == '3')
    {
      Serial.print('3');
    }
    // 4==RPI power off... RPI has send the signal that has been shut off. RPI is in stand by...
    else if(rpiStatus == '4')
    {
      Serial.print('4');
    }
    else
    {
      Serial.print('?');
    }
  }
  // 4==RPI power off... RPI has send the signal that has been shut off. RPI is in stand by...
  if(rpiStatus == '4' || rpiStatus == '0')
  {
    //Serial.println("Ready to reset RPI...");
    if ( isWakeUpHour(now.hour() ) && isWakeUpMinute(now.minute() ) && now.second()==0 )
    {
      Serial.print(':');
      digitalWrite(ledPin, HIGH);
      delay(700);
      digitalWrite(ledPin, LOW);      
    }
  }
  delay(500);
}

boolean isWakeUpHour(int currentHour)
{
 for (int i=0; i < 13;i++) 
 {
   if( currentHour == wakeUpHours[i] )
    return true;
 }
 return false;
}

boolean isWakeUpMinute(int currentMinute)
{
 for (int i=0; i < 2;i++) 
 {
   if( currentMinute == wakeUpMinutes[i] )
     return true;
 }
 return false;
}
