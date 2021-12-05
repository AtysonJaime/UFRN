int LED_RED_1 = 7;
int LED_YELLOW_1 = 6;
int LED_GREEN_1 = 5;
int LED_RED_2 = 4;
int LED_YELLOW_2 = 3;
int LED_GREEN_2 = 2;
void setup() {
  // put your setup code here, to run once:
  pinMode(LED_RED_1,OUTPUT);
  pinMode(LED_YELLOW_1,OUTPUT);
  pinMode(LED_GREEN_1,OUTPUT);
  pinMode(LED_RED_2,OUTPUT);
  pinMode(LED_YELLOW_2,OUTPUT);
  pinMode(LED_GREEN_2,OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:

  digitalWrite(LED_RED_1,HIGH);
  digitalWrite(LED_GREEN_2,HIGH);
  delay(2000);
  digitalWrite(LED_GREEN_2,LOW);
  digitalWrite(LED_YELLOW_2,HIGH);
  delay(2000);
  digitalWrite(LED_RED_1,LOW);
  digitalWrite(LED_GREEN_1,HIGH);
  digitalWrite(LED_YELLOW_2,LOW);
  digitalWrite(LED_RED_2,HIGH);
  delay(2000);
  digitalWrite(LED_GREEN_1,LOW);
  digitalWrite(LED_YELLOW_1,HIGH);
  delay(2000);
  digitalWrite(LED_RED_2,LOW);
  digitalWrite(LED_YELLOW_1,LOW);

}
