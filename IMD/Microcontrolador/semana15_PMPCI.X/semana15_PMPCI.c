/*
 * File:   semana15_PMPCI.c
 * Author: Aty
 * 
 * Confecção de um Semaforo
 *
 * Created on 10 de Setembro de 2020, 18:15
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
        
        PORTD = 0b00100100; //Acende os RD2 VERDE1 e o RD5 VERMELHO2
        __delay_ms(7000);
        PORTD = 0b00100010; //Acende os RD1 AMARELO1 e o RD5 VERMELHO2 e apaga RD2 VERDE1
        __delay_ms(3000);
        PORTD = 0b10000001; //Acende os RD0 VERMELHA1 e o RD7 VERDE2 e apaga RD1 AMARELO1 e o RD5 VERMELHO2
        __delay_ms(7000);
        PORTD = 0b01000001; //Acende os RD0 VERMELHA1 e o RD6 AMARELA2 e apaga RD7 VERDE2
        __delay_ms(3000);  
    }
}
