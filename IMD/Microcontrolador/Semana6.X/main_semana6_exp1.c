/*
 * File:   main_semana6_exp1.c
 * Author: Atyson Jaime de Sousa Martins
 * 
 * Esse experimento sera construido uma demostração de um semafaro, com botão de emergencia;
 *
 * Created on 9 de Julho de 2020, 19:48
 */


#include <xc.h>

#pragma config FOSC = INTIO67
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB

#define _XTAL_FREQ 1000000 //Habilita a função delay a funcionar na frequencia do microcontrolador
void main(void) {
    TRISD &= 11111000; //Habilita o led RD0,RD1,RD2 para saida outras maneiras: TRISDbits.RD0 = 0; TRISDbits.RD1 = 0; TRISDbits.RD2 = 0;
    TRISB |= 00000001; //Habilita o led RB0 para entrada, outra meneira TRISB = 1 ou TRISBbits.RB0 = 1
    
    while(1){
        if(PORTBbits.RB0 == 0){ // Caso o botão esteja precionado (botão com logica inversa)
            PORTD = 0b00000010; //Acende o led amarelo
            __delay_ms(1000);
            PORTD = 0b00000000; //Apaga o led amarelo
            __delay_ms(1000);
        } else { // Caso o botão não seja precionado
            PORTD = 0b00000001; //Acende o led verde
            if(PORTBbits.RB0 == 0){
                break;
            }
            __delay_ms(5000); 
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
            __delay_ms(7000);
            if(PORTBbits.RB0 == 0){
                break;
            }
        }
    }
    return;
}
