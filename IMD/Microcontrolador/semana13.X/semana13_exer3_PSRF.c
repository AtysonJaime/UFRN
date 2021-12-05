/*
 * File:   semana13_exer3_PSRF.c
 * Author: Aty
 *
 * Created on 25 de Agosto de 2020, 20:25
 */


#include <xc.h>

#pragma config FOSC = INTIO67
#pragma config WDTEN = OFF, LVP = OFF
#pragma config PBADEN = OFF

#define _XTAL_FREQ 4000000

int acionamentoBotao = 0;

void configura_serial(){
    //Utilizando uma frequencia de 4Mhz
    //Taxa de trasmissão de 2400bps
    // modo assíncrono e baixa velocidade
    OSCCONbits.IRCF = 0b101;
    TXSTA = 0b00100000;
    RCSTA = 0b10000000;
    SPBRG = 25;
}

void configuraInterrupcaoExterna(){
    INTCONbits.INT0IE = 1;          // Habilitar interrupção externa INT0
    INTCONbits.INT0IF = 0;          // Limpar flag da interrupção INT0
    INTCON2bits.INTEDG0 = 0;	// Habilitar interrupção INT0 na borda de descida
    RCONbits.IPEN = 0;           		// Desligar todas as prioridades na interrupção.
    INTCONbits.GIE = 1;           		// Habilitar interrupção geral.
}

void __interrupt() interrupcao(){
    if (INTCONbits.INT0IF == 1) {
        
        if(acionamentoBotao == 0){
            acionamentoBotao += 1;
            PORTD = 0b00000001;
            TXREG = 0b00000001;
        } else if(acionamentoBotao == 1) {
            acionamentoBotao += 1;
            PORTD = 0b00000010;
            TXREG = 0b00000010;
        } else if(acionamentoBotao == 2) {
            acionamentoBotao += 1;
            PORTD = 0b00000100;
            TXREG = 0b00000011;
        } else if(acionamentoBotao == 3) {
            acionamentoBotao += 1;
            PORTD = 0b00001000;
            TXREG = 0b00000100;
        } else if(acionamentoBotao == 4) {
            acionamentoBotao += 1;
            PORTD = 0b00010000;
            TXREG = 0b00000101;
        } else if(acionamentoBotao == 5) {
            acionamentoBotao += 1;
            PORTD = 0b00100000;
            TXREG = 0b00000110;
        } else if(acionamentoBotao == 6) {
            acionamentoBotao += 1;
            PORTD = 0b01000000;
            TXREG = 0b00000111;
        } else if(acionamentoBotao == 7) {
            acionamentoBotao += 1;
            PORTD = 0b10000000;
            TXREG = 0b00001000;
        } else {
            acionamentoBotao = 0;
            PORTD = 0b00000000;
            TXREG = 0b00000000;
        }
        
         
        INTCONbits.INT0IF = 0;     // Limpar a flag para detectar uma nova interrupção
    }
}

void main(){
    configura_serial();
    configuraInterrupcaoExterna();
    TRISC &= 0b10111111;
    TRISD = 0; //Coloca os led como saida;
    TXREG = 0b00000000;
    while(1){
        while (!(PIR1&0b00010000));
        __delay_ms(500);
    }
}
