/*
   A demo sketch for the Modern Device Rev P Wind Sensor
  Requires a Wind Sensor Rev P from Modern Device
  http://moderndevice.com/product/wind-sensor-rev-p/
  The Rev P requires at least at least an 8 volt supply. The easiest way to power it
  if you are using an Arduino is to use a 9 volt or higher supply on the external power jack
  and power the sensor from Vin.
  Hardware hookup
  Sensor     Arduino Pin
  Ground     Ground
  +10-12V      Vin
  Out          A0
  TMP          A2
  Paul Badger
  code in the public domain*/
const int numReadings = 10;


int readings[numReadings];      // the readings from the analog input
int readIndex = 0;              // the index of the current reading
int total = 0;                  // the running total
int averageWind = 0;                // the average

const int OutPin  = A0;   // wind sensor analog pin  hooked up to Wind P sensor "OUT" pin
const int TempPin = A2;   // temp sesnsor analog pin hooked up to Wind P sensor "TMP" pin

int bubbsOff = 0;
int bubbsOn = 1;


const int threshold = 310; //the microphone threshold sound level at which the LED will turn on

void setup() {
  Serial.begin(9600);

  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
}

void loop() {

  // read wind
  int windADunits = analogRead(OutPin);
  // Serial.print("RW ");   // print raw A/D for debug
  // Serial.print(windADunits);
  // Serial.print("\t");



  // wind formula derived from a wind tunnel data, annemometer and some fancy Excel regressions
  // this scalin doesn't have any temperature correction in it yet
  float windMPH =  pow((((float)windADunits - 264.0) / 85.6814), 3.36814);
  //Serial.print(" MPH\t");


  // subtract the last reading:
  total = total - readings[readIndex];
  // read from the sensor:
  readings[readIndex] = analogRead(windMPH);
  // add the reading to the total:
  total = total + readings[readIndex];
  // advance to the next position in the array:
  readIndex = readIndex + 1;


  // if we're at the end of the array...
  if (readIndex >= numReadings) {
    // ...wrap around to the beginning:
    readIndex = 0;
  }

  // calculate the average:
  averageWind = total / numReadings;
  // send it to the computer as ASCII digits
 // Serial.println(averageWind);
 //Serial.write(averageWind);

  //

      if (averageWind > threshold) {
        analogWrite (averageWind, bubbsOn);
        Serial.println(bubbsOn);
        Serial.write(bubbsOn);
      }
  
      else {
        analogWrite (averageWind, bubbsOff);
        Serial.println(bubbsOff);
        Serial.write(bubbsOff);
      }

  ////////////////////////////////////////////////////////////////////


  // temp routine and print raw and temp C
  int tempRawAD = analogRead(TempPin);
  // Serial.print("RT ");    // print raw A/D for debug
  // Serial.print(tempRawAD);
  // Serial.print("\t");

  // convert to volts then use formula from datatsheet
  // Vout = ( TempC * .0195 ) + .400
  // tempC = (Vout - V0c) / TC   see the MCP9701 datasheet for V0c and TC

  float tempC = ((((float)tempRawAD * 5.0) / 1024.0) - 0.400) / .0195;
  //  Serial.print(tempC);
  //  Serial.println(" C");
  //delay(100);

  delay(5);

}
