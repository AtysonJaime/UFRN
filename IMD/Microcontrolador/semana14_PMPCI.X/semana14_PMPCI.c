/*
 * File:   semana14_PMPCI.c
 * Author: Aty
 * 
 * Construção de um Semaforo funcional
 * 
 * Created on 4 de Setembro de 2020, 12:07
 */

#include <xc.h>

#pragma config FOSC = INTIO67
#pragma config WDTEN = OFF, LVP = OFF
#pragma config PBADEN = OFF

#define _XTAL_FREQ 1000000

void main(){
    OSCCONbits.IRCF = 0b011;
    TRISD = 0; // Confugura pin D como saida
    
    while(1) {
        //RD0 e RD5 são os sinais vermelhos
        //RD1 e RD6 são os sinais amarelos
        //RD2 e RD7 são os sinais verdes
        
        PORTD = 0b00100100;
        __delay_ms(3000);
        PORTD = 0b00100010;
        __delay_ms(1000);
        PORTD = 0b10000001;
        __delay_ms(3000);
        PORTD = 0b01000001;
        __delay_ms(1000);  
    }
}
