/*
 * File:   main1_semana8.c
 * Author: Aty
 *
 * Created on 23 de Julho de 2020, 18:56
 */


#pragma config FOSC = INTIO67
#pragma config PWRT = OFF
#pragma config WDTEN = OFF
#pragma config MCLRE = OFF
#pragma config LVP = OFF

#define _XTAL_FREQ 1000000

#include <xc.h>

void main(void) {
   
    TRISD = 0b00000000; //Ativa os LED RD como saida; 
    
    PORTD = 0b00000101; // letra A e o começo da letra B juntas
    while(1){ 
        // O LED RD2 ira acender e apagar a cada 2s enquanto os led RD4 ao RD7 ficam rotacionando a cada 500ms
       __delay_ms(500);
       PORTD = 0b00010101;
       __delay_ms(500);
       PORTD = 0b00100101;
       __delay_ms(500);
       PORTD = 0b01000101;
       __delay_ms(500);
       PORTD = 0b10000001; // LED RD2 Apaga
       __delay_ms(500);
       PORTD = 0b00010001;
       __delay_ms(500);
       PORTD = 0b00100001;
       __delay_ms(500);
       PORTD = 0b01000001;
       __delay_ms(500);
       PORTD = 0b10000101;        
    }
    return;
}