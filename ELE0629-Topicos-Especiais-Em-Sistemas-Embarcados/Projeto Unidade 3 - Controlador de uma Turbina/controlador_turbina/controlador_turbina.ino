#define BLYNK_PRINT Serial
#define ligar_motor 32
#define desligar_motor 33

#include <WiFi.h>
#include <WiFiClient.h>
#include <BlynkSimpleEsp32.h>

char auth[] = "NnweactuiRUazKDBHkyfOBL3qki62SCb";
char ssid[] = "Martins";
char pass[] = "J05UA05TK15AA01L";

WidgetLCD lcd(V0); //Funcionamento do LCD

BLYNK_CONNECTED() { // Funcionamento dos botões
  Blynk.syncVirtual(V1);
  Blynk.virtualWrite(V1, LOW);
  digitalWrite(desligar_motor, HIGH);
  digitalWrite(ligar_motor, LOW);
  lcd.clear();
  lcd.print(0, 0, "Seja bem-vindo!");
  lcd.print(0, 1, "Motor Control");
}

BLYNK_WRITE(V1) // Ligar o motor

{
  int pinValue = param.asInt();
  if (pinValue == 1) {
    digitalWrite(ligar_motor, HIGH);
    digitalWrite(desligar_motor, LOW);
    lcd.clear();
    lcd.print(2 , 0, "Motor Ligado");
  } else {
    digitalWrite(ligar_motor, LOW);
    digitalWrite(desligar_motor, HIGH);
    lcd.clear();
    lcd.print(0, 0, "Motor Desligado");
  }
};

void setup()
{
  // Debug console
  Serial.begin(9600);
  pinMode(ligar_motor, OUTPUT);
  pinMode(desligar_motor, OUTPUT);

  Blynk.begin(auth, ssid, pass);
}

void loop()
{
  Blynk.run();
}
