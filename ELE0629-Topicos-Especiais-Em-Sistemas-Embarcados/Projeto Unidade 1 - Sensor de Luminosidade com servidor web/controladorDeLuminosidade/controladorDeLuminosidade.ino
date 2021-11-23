/*
  Servidor Web com ESP32

  Utilização de um servidor web para monitoramente de luminosidade em uma sala.

  Verificação da intensidade da luz em uma sala, por exemplo, uma estufa.
  Esse monitoramente é realizado atravez de um servidor web, onde o usuario pode aumentar ou diminuir a intensidade da luz
  insidente sobre a sala.
   
*/
#include <SPI.h>
#include <WiFi.h>

// Wifi config
char ssid[] = "Martins";      //  Nome da sua rede
char pass[] = "J05UA05TK15AA01L";   // Senha da sua rede
int keyIndex = 0;                 // your network key Index number (needed only for WEP)
int status = WL_IDLE_STATUS;
WiFiServer server(80);

//Analog Input
#define ANALOG_PIN_0 32 // Define a entrada analogica
int analog_value = 0;  // Inicializa a entrada como zero
int LDR_value_porcentagem = 0;  // Trasnforma valor recebido em porcentagem

// PWM LED
#define LED_PIN 14    // Definição da porta do LED
int freq = 5000;      // Frequencia utilizada para onda quadrada
int ledChannel = 0;   // Canal do PWM
int resolution = 8;   // Resolução do PWM
int dutyCycle = 0;    // Inicialização do dutyCycle


void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("Controlador de Luminosidade via webServer com ESP32");
  Serial.println("Dev: Atyson Jaime de Sousa Martins");
  Serial.println("E-Mail: atysonjaime@gmail.com");
  Serial.println("");

  // Conf PWM
  ledcSetup(ledChannel, freq, resolution);
  ledcAttachPin(LED_PIN, ledChannel);
  ledcWrite(ledChannel, dutyCycle);

  // Conectando a rede wifi
  criaConecao();
}


void loop() {
  WiFiClient client = server.available();
  
  if (client) {                             
    Serial.println("Ola!, Seja bem vindo(a)!");
    String currentLine = "";                
    while (client.connected()) {            
      analog_value = analogRead(ANALOG_PIN_0);
      LDR_value_porcentagem = map(analog_value, 0, 2870, 0, 100);
      if (client.available()) {             
        char c = client.read();             
        Serial.write(c);                    
        if (c == '\n') {                    
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println();

            // Estrutura HTML
            client.print("<html lang='pt-br'>");
            client.print("<head><meta charset='UTF-8'><meta http-equiv='X-UA-Compatible' content='IE=edge'>");
            client.print("<meta name='viewport' content='width=device-width, initial-scale=1.0'><title>Controlador de Luminosidade</title>");
            client.print("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css' integrity='sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l' crossorigin='anonymous'>");
            client.print("<style>html,body {height: 100%;background-color: #333;};</style></head>");
            client.print("<body><div class='w-100 h-100 d-flex flex-column justify-content-center align-items-center'>");
            client.print("<h1 class='text-white text-center m-4'>Controlador de Luminosidade</h1><div class='d-flex w-100 justify-content-around flex-wrap'>");
            client.print("<div class='text-center m-4' style='border: 2px solid white; padding: 30px; color: white;'><h4>Porcentagem de Luminosidade: </h4>");
            client.print("<h6>");
            client.print(LDR_value_porcentagem);
            client.print("</h6></div><div class='m-4'>");
            client.print("<div class='d-flex flex-wrap justify-content-around align-items-center'>");
            client.print("<a class='btn btn-lg btn-success m-2' title='Ligar Luz' href='/Ligar'>Ligar Luz</a>");
            client.print("<a class='btn btn-lg btn-danger m-2' title='Desligar Luz' href='/Desligar'>Desligar Luz</a>");
            client.print("</div><div class='d-flex flex-wrap justify-content-around align-items-center'>");
            if(dutyCycle != 255){
              client.print("<a class='btn btn-lg btn-primary m-2' title='Aumento em 10%' href='/Aumentar'>Aumentar Luminosidade</a>");
            } else {
              client.print("<a class='btn btn-lg btn-primary m-2' title='Aumento em 10%' href='/Aumentar' disabled>Aumentar Luminosidade</a>");
            }
            if(dutyCycle != 0){
              client.print("<a class='btn btn-lg btn-secondary m-2' title='Reduz em 10%' href='/Reduzir'>Reduzir Luminosidade</a>");
            } else {
              client.print("<a class='btn btn-lg btn-secondary m-2' title='Reduz em 10%' href='/Reduzir' disabled>Reduzir Luminosidade</a>");
            }
            client.print("</div></div></div></div></body></html>");

            // The HTTP response ends with another blank line:
            client.println();
            break;
          } else {
            currentLine = "";
          }
        } else if (c != '\r') {
          currentLine += c;
        }

        // Testas as requisições "GET /Ligar" ou "GET /Desligar" ou "GET /Aumentar" or "GET /Reduzir":
        if (currentLine.endsWith("GET /Ligar")) {
          dutyCycle = 255;
          ledcWrite(ledChannel, dutyCycle); // GET /Ligar a luz é Ligada             
        }
        if (currentLine.endsWith("GET /Desligar")) {
          dutyCycle = 0;
          ledcWrite(ledChannel, dutyCycle); // GET /Desligar a luz é Desligada
        }
        if (currentLine.endsWith("GET /Aumentar")) {
          if(!dutyCycle != 255) {
              dutyCycle = dutyCycle + 25.5;
              ledcWrite(ledChannel, dutyCycle); // GET /Aumentar a luminosidade é aumentada em 10%
           };
        }
        if (currentLine.endsWith("GET /Reduzir")) {
          if(dutyCycle != 0) {
              dutyCycle = dutyCycle - 25.5;
              ledcWrite(ledChannel, dutyCycle); // GET /Reduzir a luminosidade é reduzida em 10%
           };
          
        }
      }
    }
    client.stop();
    Serial.println("Ah que pena! Já vai embora ?!, Tudo bem, volte sempre!");
  }
}

void criaConecao(){  
  Serial.print("Tentando conexão a rede: ");
  Serial.println(ssid);
  while (status != WL_CONNECTED) {
    status = WiFi.begin(ssid, pass);
    Serial.print("Conectando...");
    delay(10000);
  }
  Serial.print("Conectado");
  server.begin();                      
  printWifiStatus();
};

void printWifiStatus() {
  Serial.print("SSID: ");
  Serial.println(WiFi.SSID());

  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);

  long rssi = WiFi.RSSI();
  Serial.print("signal strength (RSSI):");
  Serial.print(rssi);
  Serial.println(" dBm");
  // print where to go in a browser:
  Serial.print("Por favor, acesse a pagina através do endereço: http://");
  Serial.println(ip);
};
