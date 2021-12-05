/*
 * File:   main_semana10_RF.c
 * Author: Aty
 *
 * Created on 6 de Agosto de 2020, 20:22
 */


#pragma config FOSC = INTIO67
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB
#pragma config PWRT = OFF
#pragma config WDTEN = OFF
#pragma config MCLRE = OFF
#pragma config LVP = OFF

#define _XTAL_FREQ 1000000

#include <xc.h>

void main(void) {
    
    TRISD = 0; //Configura LEDS para saida
    
    while(1){
        PORTD = 16; // Liga o RD4
        __delay_ms(500);
        PORTD = 0; // Desliga o RD4
        __delay_ms(300);
    }
    
    return;
}
