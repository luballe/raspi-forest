// Date and time functions using a DS1307 RTC connected via I2C and Wire lib

#include <Wire.h>
#include "RTClib.h"
#include <SimpleList.h>

RTC_DS1307 rtc;

SimpleList<int> wakeUpHours;
SimpleList<int> wakeUpMinutes;

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
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
    // This line sets the RTC with an explicit date & time, for example to set
    // January 21, 2014 at 3am you would call:
    // rtc.adjust(DateTime(2015, 6, 15, 11, 5, 0));
  }
  
  //Set waking hours
  wakeUpHours.push_back(6);
  wakeUpHours.push_back(7);
  wakeUpHours.push_back(8);
  wakeUpHours.push_back(9);
  wakeUpHours.push_back(10);
  wakeUpHours.push_back(11);
  wakeUpHours.push_back(12);
  wakeUpHours.push_back(13);
  wakeUpHours.push_back(14);
  wakeUpHours.push_back(15);
  wakeUpHours.push_back(16);
  wakeUpHours.push_back(17);
  wakeUpHours.push_back(18);
  
  //Set waking minutes
  wakeUpMinutes.push_back(0);
  wakeUpMinutes.push_back(15);
  wakeUpMinutes.push_back(30);
  wakeUpMinutes.push_back(45);
        
}

void loop () {
    DateTime now = rtc.now();
    Serial.print(now.year(), DEC);
    Serial.print('/');
    Serial.print(now.month(), DEC);
    Serial.print('/');
    Serial.print(now.day(), DEC);
    Serial.print(' ');
    Serial.print(now.hour(), DEC);
    Serial.print(':');
    Serial.print(now.minute(), DEC);
    Serial.print(':');
    Serial.print(now.second(), DEC);

    if ( isWakeUpHour(now.hour() ) && isWakeUpMinute(now.minute() ) && now.second()==0)
    {
       Serial.print(':');
    }
    
    Serial.println();
    delay(1000);
}

boolean isWakeUpHour(int currentHour)
{
 for (SimpleList<int>::iterator itr = wakeUpHours.begin(); itr != wakeUpHours.end();itr++) 
 {
   if( currentHour == (*itr) )
    return true;
 }
 return false;
}

boolean isWakeUpMinute(int currentMinute)
{
 for (SimpleList<int>::iterator itr = wakeUpMinutes.begin(); itr != wakeUpMinutes.end();itr++) 
 {
   if( currentMinute == (*itr) )
     return true;
 }
 return false;
}
