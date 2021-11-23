/****************************************************** 
* ESP32 Analog Input Test 
* Analog Input: ADC_1_0 pin ==> GPIO32+ (VP).
* 
* MJRoBot.org 6Sept17
*****************************************************/
//Analog Input
#define ANALOG_PIN_0 32

int analog_value = 0;
int LDR_value_porcentagem = 0;

// PWM LED
#define LED_PIN 14
int freq = 5000;
int ledChannel = 0;
int resolution = 8;
int dutyCycle = 0;

void setup()
{
  Serial.begin(115200);
  delay(1000); // give me time to bring up serial monitor
  Serial.println("ESP32 Analog wifh PWM");
  
  ledcSetup(ledChannel, freq, resolution);
  ledcAttachPin(LED_PIN, ledChannel);
  ledcWrite(ledChannel, dutyCycle);
}

void loop()
{
  analog_value = analogRead(ANALOG_PIN_0);
  
  LDR_value_porcentagem = map(analog_value, 0, 3500, 0, 100);
  Serial.print("LDR = ");
  Serial.println(analog_value);
  Serial.print("LDR  Poercentagem = ");
  Serial.println(LDR_value_porcentagem);
  if(LDR_value_porcentagem == 0) {
    dutyCycle = 255;
    ledcWrite(ledChannel, dutyCycle);
  } else if(LDR_value_porcentagem > 0 && LDR_value_porcentagem <= 50) {
      dutyCycle = 170;
      ledcWrite(ledChannel, dutyCycle);
    } else if(LDR_value_porcentagem > 50 && LDR_value_porcentagem <= 100) {
        dutyCycle = 85;
        ledcWrite(ledChannel, dutyCycle);
      } else {
          dutyCycle = 0;
          ledcWrite(ledChannel, dutyCycle);
        };
  Serial.print("LED = ");
  Serial.println(dutyCycle);
  delay(1000);
}
