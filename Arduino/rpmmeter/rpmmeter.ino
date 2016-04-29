#include <Wire.h>
#include <LiquidCrystal_I2C.h>

#define BACKLIGHT_PIN   13
volatile byte rpmcount;
unsigned int rpm;
unsigned long time; 

LiquidCrystal_I2C lcd(0x27, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);


void rpm_count()
 {
      rpmcount++;
 }

void setup()
 {

   Serial.begin(9600);
   attachInterrupt(0, rpm_count, RISING);

   pinMode ( BACKLIGHT_PIN, OUTPUT );
   digitalWrite ( BACKLIGHT_PIN, HIGH );
   
   lcd.begin(16,2);               // initialize the lcd 

   lcd.home ();                   // go home
   lcd.print("RPM Meter v1.0");  
   rpmcount = 0;
   rpm = 0;
   time = 0;
 }

 void loop()
 {
   delay(1000);

   //Update RPM every second   
   detachInterrupt(0);
   
   rpm = 30*1000/(millis() - time)*rpmcount;
   time = millis();
   rpmcount=0; 
  
   //Restart the interrupt processing
   attachInterrupt(0, rpm_count, RISING);
   lcd.clear();
   lcd.print("RPM = ");
   lcd.print(rpm,DEC);
   
  }

