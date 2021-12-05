/*
 * File:   semana15_psrf_trasmissor.c
 * Author: Aty
 *
 * Created on 8 de Setembro de 2020, 20:32
 */


// inclui a biblioteca do compilador do MPLAB
#include <xc.h>

// desliga as configurações watchdog time e programação em baixa tensão
#pragma config WDTEN = OFF, LVP = OFF

// "PBADEN = OFF" define que os bits 1, 2, 3 e 4 da porta B
// devem ser configurados como pinos I/O digitais.
#pragma config PBADEN = OFF
#pragma config FOSC = INTIO67

// define a frequência utilizada pelo microcontrolador
#define _XTAL_FREQ 1000000

// esta função serve apenas para organizar o código
// ela configura os registradores da comunicação
// serial. Para este caso, 1200 bps, 8 bits, sem
// bit de paridade e 1 stop bit
void configura_serial(void) {
    OSCCONbits.IRCF = 0b011;
    // configura o transmissor
    TXSTA = 0b00100000;
    // configura o receptor
    RCSTA = 0b10010000;
    // velocidade = Fosc/(64*(SPBRG+1))
    SPBRG = 12; // 1200 bps
}

void main(void) {
    unsigned char chave; // variável que verificará o estado da chave
    TRISB = 0xff;  // configura a porta B como entrada -> So para ser algo q inicia o envio
    configura_serial(); // chama a função para configurar a serial
    TRISD = 0x00;  // Configura o PORTD, como saída para sinalizar envio
    
    while(1){ 
        chave = PORTB; //ler o estado da chave
        
        if(chave >0) { // se a chave estiver pressionada
            for(int i = 0; i< 10; i++){
               TXREG = 0b01010101; // transmite o valor 85 (bits alternados)
               PORTD = 0x01;  //acende o led indicador de transmissão
               while(!(PIR1&0b00010000));  // espera transmitir o byte
               __delay_ms(500); //aguarda meio segundo
               PORTD = 0x00; //apaga o led indiciador de trasmissão 
            }
        }
    }
    
    return;
}
