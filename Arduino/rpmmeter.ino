#define aipr 1 // amount of interupts per round

volatile byte rpmcount;
unsigned int rpm;
unsigned long time; 

void rpm_count()
 {
      rpmcount++;
 }

void setup()
 {

   Serial.begin(9600);
   attachInterrupt(0, rpm_count, FALLING);


   rpmcount = 0;
   rpm = 0;
   time = 0;
 }

 void loop()
 {
   //Update RPM every second
   delay(1000);
   
   detachInterrupt(0);

   rpm = (60/aipr)*1000/(millis() - time)*rpmcount;
   time = millis();
   rpmcount = 0;

   Serial.println(rpm);

   //Restart the interrupt processing
   attachInterrupt(0, rpm_count, FALLING);
  }

