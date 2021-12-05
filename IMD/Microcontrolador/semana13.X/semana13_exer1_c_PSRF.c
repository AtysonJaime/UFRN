/*
 * File:   semana13_exer1_c_PSRF.c
 * Author: Aty
 *
 * Created on 25 de Agosto de 2020, 19:51
 */


#include <xc.h>

#pragma config FOSC = INTIO67
#pragma config WDTEN = OFF, LVP = OFF
#pragma config PBADEN = OFF

#define _XTAL_FREQ 1000000

void configura_serial(){
    OSCCONbits.IRCF = 0b011;
    TXSTA = 0b00100000;
    RCSTA = 0b10000000;
    SPBRG = 51;
}

void main(){
    configura_serial();
    TRISC &= 0b10111111;
    while(1){
        TXREG = 0b00011001;
        while (!(PIR1&0b00010000));
        __delay_ms(500);
    }
}
