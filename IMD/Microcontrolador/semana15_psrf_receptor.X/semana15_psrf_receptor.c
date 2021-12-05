/*
 * File:   semana15_psrf_receptor.c
 * Author: Aty
 *
 * Created on 8 de Setembro de 2020, 20:42
 */


// inclui a biblioteca do compilador do MPLAB
#include <xc.h>

// desliga as configurações watchdog time e programação em baixa tensão
#pragma config WDTEN = OFF, LVP = OFF

// "PBADEN = OFF" define que os bits 1, 2, 3 e 4 da porta B
// devem ser configurados como pinos I/O digitais.
#pragma config PBADEN = OFF
#pragma config FOSC = INTIO67

// define a frequência utilizada pelo microcontrolador
#define _XTAL_FREQ 1000000

// esta função serve apenas para organizar o código
// ela configura os registradores da comunicação
// serial. Para este caso, 1200 bps, 8 bits, sem
// bit de paridade e 1 stop bit
void configura_serial(void) {
    OSCCONbits.IRCF = 0b011;
    // configura o transmissor
    TXSTA = 0b00100000;
    // configura o receptor
    RCSTA = 0b10010000;
    // velocidade = Fosc/(64*(SPBRG+1))
    SPBRG = 12; // 1200 bps
}

void main(void) {
    unsigned char valor_recebido; // variável que armazenará o valor recebido da serial
    
    configura_serial(); //chama a função para configurar a serial
    
    TRISD = 0x00; //Configura a port D como saida;
    
    while(1) {
        RCSTA = 0b10010000; //Prepara para receber;
        while((PIR1%32)==0); //espera chegar algum dado na serial;
        valor_recebido = RCREG; //ler o valor recebido;
        RCSTA = 0b10000000; //reseta a serial para uma nova recepção
        // compara para ver se é o valor correto
        // e então acende o LED
        if(valor_recebido == 85){
            PORTD = 0b00001111;
        }
        //espera alguns instantes
        __delay_ms(300);
        
        //apaga o LED
        PORTD = 0;
    };
    return;
}