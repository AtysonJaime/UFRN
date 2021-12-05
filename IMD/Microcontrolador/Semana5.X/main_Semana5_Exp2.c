/*
 * File:   main_Semana5_Exp2.c
 * Author: Atyson Jaime de Sousa Martins
 *
 * Nesse codigo, os leds nos pinos RD0, RD1,RD2,RD3 s�o acionados quando o Bot�o sw1 (RB0) � acionado
 * e os leds nos pinos RD4,RD5,RD6, RD7 s�o acionados quando o bot�o sw1 (RB0) n�o estiver acionado
 * 
 * Created on 2 de Julho de 2020, 20:55
 */


#include <xc.h>
#pragma config FOSC = INTIO67
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB

void main(void) {
    TRISD = 0; //Diz que os pinos D ser�o de saida;
    TRISBbits.RB0 = 1; //Diz que o pino RB0 ser� de entrada. Esse bot�o possue logica inversa, abertado(nivel logico 0) e desapertado (nivel logico 1) 
    
    while(1){
        if (PORTBbits.RB0 == 0) {
            PORTD = 15; //15(Decimal) -> 0b00001111 (binario) // Aciona os leds RD0, RD1, RD2, RD3
        }
        else {
            PORTD = 240; //15(Decimal) -> 0b11110000 (binario) // Aciona os leds RD4, RD5, RD6, RD7
        }
    }
    return;
}
