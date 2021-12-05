/*
 * File:   main_Semana5_Exp1.c
 * Author: Atyson Jaime de Sousa MArtins
 * 
 * Nesse codigo os leds nos pinos RD1, RD3, RD5 e RD7 são ligados na placa.
 *
 * Created on 2 de Julho de 2020, 19:47
 */


#include <xc.h>
#pragma config FOSC = INTIO67

void main(void) {
    //Intruções que serão realizadas uma unica vez
    TRISD = 0; // Ativa os pinos D para ser de saida
    
    while(1){
    // Intruções que serão utilizadas varias vezes.
        PORTD = 170;// 170(Decimal) // 0b10101010 (binario) // Aciona os leds desejados para nivel logico alto 
        
        //Outras maneiras para acender os msm lds:
        
        //PORTDbits.RD1 = 1;// Aciona os leds desejados para nivel logico alto 
        //PORTDbits.RD3 = 1;// Aciona os leds desejados para nivel logico alto 
        //PORTDbits.RD5 = 1;// Aciona os leds desejados para nivel logico alto 
        //PORTDbits.RD7 = 1; // Aciona os leds desejados para nivel logico alto    
    }
    
    return;
}
