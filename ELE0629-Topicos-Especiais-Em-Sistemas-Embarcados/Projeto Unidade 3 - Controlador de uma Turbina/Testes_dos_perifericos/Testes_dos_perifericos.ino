
#define LED_PIN_Green 32    // Definição da porta do LED
#define LED_PIN_Red 33    // Definição da porta do LED
#define Motor_PIN 25    // Definição da porta do LED

void setup() {
  pinMode(LED_PIN_Green, OUTPUT);
  pinMode(LED_PIN_Red, OUTPUT);
  pinMode(Motor_PIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_PIN_Red, HIGH);
  digitalWrite(LED_PIN_Green, LOW);
  digitalWrite(Motor_PIN, LOW);
  delay(1000);
  digitalWrite(LED_PIN_Red, LOW);
  digitalWrite(LED_PIN_Green, HIGH);
  digitalWrite(Motor_PIN, LOW);
  delay(1000);
  digitalWrite(LED_PIN_Red, LOW);
  digitalWrite(LED_PIN_Green, LOW);
  digitalWrite(Motor_PIN, HIGH);
  delay(1000);
}
