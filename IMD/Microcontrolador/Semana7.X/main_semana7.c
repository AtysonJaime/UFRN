/*
 * File:   main_semana7.c
 * Author: Atyson Jaime de Sousa Martins
 * 
 * Projeto de construção de um joguinho chamado Check Light;
 *
 * Created on 16 de Julho de 2020, 18:27
 */

#pragma config FOSC = INTIO67
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB

#define _XTAL_FREQ 1000000
#include <xc.h>
void __interrupt() interrupcao(){
    if(INTCONbits.INT0IF == 1){
        if(PORTD == 0b00011000){
            for(int i = 0; i <= 2000;i+=200){
                PORTD = 0b11111111;
                __delay_ms(100);
                PORTD = 0b00000000;
                __delay_ms(100);
            };
        }
        INTCONbits.INT0IF = 0;
    }
}
void main(void) {
    TRISD &= 0b00000000; // Configura os leds RD0 ate RD7 como saida;
    TRISB |= 0b00000001; // Configura o botão SW1(RB0) como entrada; 
    //Aqui começa a configuração do registrador para interrupção
    INTCONbits.INT0IE = 1;
    INTCONbits.INT0IF = 0;
    INTCON2bits.INTEDG0 = 0;
    RCONbits.IPEN = 0;
    INTCONbits.GIE = 1;
    //Finalização das configurações de interrupção
    
    PORTD = 0b00000000;
    __delay_ms(70);
    while(1) {
        PORTD = 0b00000011;
        __delay_ms(70);
        PORTD = 0b00000110;
        __delay_ms(70);
        PORTD = 0b00001100;
        __delay_ms(70);
        PORTD = 0b00011000;
        __delay_ms(70);
        PORTD = 0b00110000;
        __delay_ms(70);
        PORTD = 0b01100000;
        __delay_ms(70);
        PORTD = 0b11000000;
        __delay_ms(70);
        PORTD = 0b10000001;
        __delay_ms(70);
    }
        
    return;
}
