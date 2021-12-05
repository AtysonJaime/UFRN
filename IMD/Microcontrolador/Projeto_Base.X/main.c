/*
 * File:   main.c
 * Author: Aty
 *
 * Created on 1 de Julho de 2020, 22:28
 */


#include <xc.h>

#pragma config FOSC = INTIO67
#pragma config BOREN = ON 
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB

#define _XTAL_FREQ //Valor da frequencia selecionada;

void main(void) {
    
    OSCCONbits.IRCF = 0b101 // Set Frequencia
    
    TRISD = 0;//Registrador que define entrada(1) ou saida(0)
    TRISBbits.RB0 = 1; //Define o botão como entrada
    while(1){
        if(PORTBbits.RB0 == 0) { // O bitão possie logica inversa 0 ligado, 1 desligado
            PORTD = 0b10101010;
        } 
        else {
            PORTD = 0b01010101;
            __delay_ms(1000); // Delay
        }
        // PORTD = 0b11111111;Registrador para definir nivel logico alto(1) e baixo(0)
        //PORTD = 1 // LIGO SO O PINO PD0
    }
    
    return;
}
