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

// Wind sensor analog pins.
const int sensor1 = A0;
const int sensor2 = A1;
const int sensor3 = A2;

void setup() {
  Serial.begin(9600);
}

float round_to_dp(float in_value, int decimal_place) {
  float multiplier = powf( 10.0f, decimal_place );
  in_value = roundf( in_value * multiplier ) / multiplier;
  return in_value;
}

float readSensor(int sensor) {
  // Read wind.
  int windADunits = analogRead(sensor);

  // Wind formula derived from a wind tunnel data,
  // annemometer and some fancy Excel regressions.
  // This scalin doesn't have any temperature correction in it yet.
  float offset = 264.0;

  float windMPH = windADunits < offset ? 0 : pow((((float)windADunits - offset) / 85.6814), 3.36814);
  return round_to_dp(windMPH, 2);
}

void loop() {
  float mph1 = readSensor(sensor1);
  float mph2 = readSensor(sensor2);
  float mph3 = readSensor(sensor3);

  Serial.print(String("") + mph1 + ":" + mph2 + ":" + mph3 + "\n");
  delay(16);
}
