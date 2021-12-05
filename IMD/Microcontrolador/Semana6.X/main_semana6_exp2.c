/*
 * File:   main_semana6_exp2.c
 * Author: Atyson Jaime de Sousa Martins
 *
 *Esse experimento sera construido uma demostra��o de um semafaro, com bot�o de emergencia para acionamente de um sinal sonoro;
 * 
 * Created on 10 de Julho de 2020, 14:50
 */


#include <xc.h>

#pragma config FOSC = INTIO67
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB

#define _XTAL_FREQ 1000000 //Habilita a fun��o delay a funcionar na frequencia do microcontrolador

void main(void) {
    TRISD &= 01111000; //Habilita o led RD0,RD1,RD2,RD7 para saida outras maneiras: TRISDbits.RD0 = 0; TRISDbits.RD1 = 0; TRISDbits.RD2 = 0; TRISDbits.RD7 = 0;
    TRISB |= 00000001; //Habilita o led RB0 para entrada, outra meneira TRISB = 1 ou TRISBbits.RB0 = 1
    
    while(1){
        int ahAbertoNoBotao = 0;
        while (ahAbertoNoBotao < 4){
            if(PORTBbits.RB0 == 0){ // Caso o bot�o esteja precionado (bot�o com logica inversa)
                ahAbertoNoBotao++;
            } else { // Caso o bot�o n�o seja precionado
                PORTD = 0b00000001; //Acende o led verde
                if(PORTBbits.RB0 == 0){
                    break;
                }
                __delay_ms(8000); 
                if(PORTBbits.RB0 == 0){
                    break;
                }
                PORTD = 0b00000010; //Acende o led amarelo
                if(PORTBbits.RB0 == 0){
                    break;
                }
                __delay_ms(2000);
                if(PORTBbits.RB0 == 0){
                    break;
                }
                PORTD = 0b00000100; //Acende o led vermelho
                if(PORTBbits.RB0 == 0){
                    break;
                }
                __delay_ms(4000);
                if(PORTBbits.RB0 == 0){
                    break;
                }
            }
        };
        PORTD &= 0b00000000;
        PORTD = 0b10000000;
        __delay_ms(5000);
    }
    return;
}