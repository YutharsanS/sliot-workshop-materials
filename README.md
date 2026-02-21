# SLIOT 2026 Workshop Materials

## Installation Guide 

Download this [batchfile](https://github.com/YutharsanS/sliot-workshop-materials/raw/refs/heads/main/install.bat) and **run as administrator**

## Pinout Guide

### Pin Reference
![Pin Reference](https://lastminuteengineers.com/wp-content/uploads/iot/ESP32-Pinout.png)

### Safe Pins
![Strap Pins](https://lastminuteengineers.com/wp-content/uploads/iot/ESP32-GPIO-Pins-that-are-Safe-to-Use.png)

Images are adopted from this article : https://lastminuteengineers.com/esp32-pinout-reference

## Demonstration Guides

### Blink

<img width="auto" height="auto" alt="52" src="https://github.com/user-attachments/assets/875c88b7-5d0d-4e2a-a953-ef9ce27b8acb" />

```cpp
int LED_BUILTIN = 2;
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);  // turn the LED on (HIGH is the voltage level)
  delay(1000);                      // wait for a second
  digitalWrite(LED_BUILTIN, LOW);   // turn the LED off by making the voltage LOW
  delay(1000);                      // wait for a second
}
```

### LED Fade
<img width="auto" height="auto" alt="55" src="https://github.com/user-attachments/assets/385a16df-d466-470a-b41a-9c6bc431714b" />

```cpp
int LED_PIN = 4;
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_PIN, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
for (int brightness = 0; brightness <= 255; brightness++) {
    analogWrite(LED_PIN, brightness);
    delay(10); // Adjust the speed of fading
  }

  // Decrease brightness
  for (int brightness = 255; brightness >= 0; brightness--) {
    analogWrite(LED_PIN, brightness);
    delay(10);
  }
}
```

### Buzzer
<img width="auto" height="auto" alt="56" src="https://github.com/user-attachments/assets/462d4e90-9e02-4ab2-9dda-ab26b32f4e2b" />

```cpp
#define BUZZER_PIN 4 // sama as int Buzzer_pin = 4
int frequency = 200; //200hz

void setup() {
  pinMode(BUZZER_PIN,OUTPUT);
}

void loop() {
  tone(BUZZER_PIN,frequency,1000);
  noTone(BUZZER_PIN);
  delay(1000);
 }
```

### Servo Motor
<img width="auto" height="auto" alt="58" src="https://github.com/user-attachments/assets/c0cb9d13-4931-40de-abf7-b1f2344412ba" />

```cpp/* ESP32 Servo Sweep */
#include <ESP32Servo.h>

const int servoPin = 4; /* GPIO14 */

Servo servo1;

void setup()
{ 
 Serial.begin(115200);
 servo1.attach(servoPin);

}
void loop()
{
  for(int posDegrees = 0; posDegrees <= 180; posDegrees++) {
    servo1.write(posDegrees);
    Serial.println(posDegrees);
    delay(20);
  }

  for(int posDegrees = 180; posDegrees >= 0; posDegrees--) {
    servo1.write(posDegrees);
    Serial.println(posDegrees);
    delay(20);
  }
}
```

### Push Button - Active HIGH
<img width="auto" height="auto" alt="64" src="https://github.com/user-attachments/assets/69fc17e8-9fd3-47de-bbdb-e2740fa4d464" />


### Push Button - Active LOW
<img width="auto" height="auto" alt="66" src="https://github.com/user-attachments/assets/b3a046d6-7105-4fd4-8768-af70cc077285" />

### LDR-Analog Input
<img width="auto" height="auto" alt="68" src="https://github.com/user-attachments/assets/140a4b20-45aa-4c10-a127-c324b737cd9a" />

### DHT11
<img width="auto" height="auto" alt="71" src="https://github.com/user-attachments/assets/89628b8d-6adf-4d6b-b92c-d728b6f56fd2" />

### All together - Simple project
<img width="auto" height="auto" alt="74" src="https://github.com/user-attachments/assets/18c7418e-f916-4229-8cee-2c1618f58696" />

---

### Servo Motors

Servo motor pinout <br/> 
![Servo Pinout](https://i.pinimg.com/originals/8a/79/fa/8a79fa7c5dbbea9852c047172b00b304.jpg)

#### Installing EspServo library
<img width="auto" height="auto" alt="Arduino_IDE_GiALowRumc" src="https://github.com/user-attachments/assets/fc28e43d-c463-4265-9ed6-e1e531fa956a" />

