/*
 * File:   main_semana10.c
 * Author: Aty
 *
 * Created on 4 de Agosto de 2020, 18:46
 */
#pragma config FOSC = INTIO67
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB
#pragma config PWRT = OFF
#pragma config WDTEN = OFF
#pragma config MCLRE = OFF
#pragma config LVP = OFF

#define _XTAL_FREQ 4000000

#include <xc.h>

int valueAD = 0;
int led7Acesso = 0;
int cont = 0;

void configuraConversorAD() {
    ADCON2bits.ADCS = 0b110; // Clock: Fosc/64
    ADCON2bits.ACQT = 0b101; // Tempo de aquisição: 12*TAD
    ADCON2bits.ADFM = 1; // Formato do valor digital justificado à direita.
    ADCON1 = 0b00000000; // ADC Vref = Vdd,Vss
    ANSEL |= 0b00000001; // Configura RA0 como analógica
    TRISA |= 0b00000001; // Configura RA0 como entrada
    ADCON0bits.CHS = 0b0000; // Configura canal AN0 (RA0)
    ADCON0bits.ADON = 1; // Habilitar conversor AD
}

void configuraTemporizador(){
    T0CONbits.TMR0ON = 0; // Parar o contador TIMER0
    T0CONbits.T08BIT = 0; // Selecionar o modo 16-bits
    T0CONbits.T0CS = 0; // Selecionar o clock interno
    T0CONbits.PSA = 0; // Selecionar o prescaler
    T0CONbits.T0PS = 0; // Prescaler: dividir 1:2
    INTCONbits.TMR0IE = 1; // Habilitar o TIMER0
    INTCONbits.TMR0IF = 0; // Limpar a flag do TIMER0
    T0CONbits.TMR0ON = 1; // Iniciar o TIMER0

    INTCONbits.GIE = 1; // Habilitar a interrupção geral
    INTCONbits.PEIE = 1; // Habilitar a interrupção de periferica; TIMER0 = Periférico.
}

void ligaDesligaLed7() {
    if(!led7Acesso){
        PORTD = 64;
        led7Acesso = 1;
    } else {
        PORTD = 0;
        led7Acesso = 0;
    }
}

void __interrupt() interrupcao(){ 
    // 0V - 0 - 131ms
    // 3.3V - 1024 - 2096s
    if (INTCONbits.TMR0IF == 1){
        ADCON0bits.GO = 1; // Iniciar conversão
        while (ADCON0bits.GO){};  // Esperar a conversão finalizar
        valueAD = (ADRESH << 8) + ADRESL;
        if(valueAD < 64) {
            cont = cont + 1;
            if(cont == 2){
                ligaDesligaLed7();
                cont = 0;
            }
        } else if(valueAD >= 64 && valueAD < 64*2) {
            cont = cont + 1;
            if(cont == 3){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*2 && valueAD < 64*3) {
            cont = cont + 1;
            if(cont == 4){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*3 && valueAD < 64*4) {
            cont = cont + 1;
            if(cont == 5){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*4 && valueAD < 64*5) {
            cont = cont + 1;
            if(cont == 6){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*5 && valueAD < 64*6) {
            cont = cont + 1;
            if(cont == 7){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*6 && valueAD < 64*7) {
            cont = cont + 1;
            if(cont == 8){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*7 && valueAD < 64*8) {
            cont = cont + 1;
            if(cont == 9){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*8 && valueAD < 64*9) {
            cont = cont + 1;
            if(cont == 10){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*9 && valueAD < 64*10) {
            cont = cont + 1;
            if(cont == 11){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*10 && valueAD < 64*11) {
            cont = cont + 1;
            if(cont == 12){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*11 && valueAD < 64*12) {
            cont = cont + 1;
            if(cont == 13){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*12 && valueAD < 64*13) {
            cont = cont + 1;
            if(cont == 14){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*13 && valueAD < 64*14) {
            cont = cont + 1;
            if(cont == 15){
                ligaDesligaLed7();
                cont = 0;
            }
        }else if(valueAD >= 64*14 && valueAD < 64*15) {
            cont = cont + 1;
            if(cont == 16){
                ligaDesligaLed7();
                cont = 0;
            }
        }else {
            cont = cont + 1;
            if(cont == 17){
                ligaDesligaLed7();
                cont = 0;
            }
        }
        INTCONbits.TMR0IF = 0;     //Limpar a flag para detectar a interrupcao por clock
    }
}

void main(void) {
    OSCCONbits.IRCF = 0b110; // Configurar oscilador interno para 4MHz
    
    configuraConversorAD();
    configuraTemporizador();
    
    TRISD = 0; //Configura todos os pinos D para saida
    
    while(1) {}
    
    return;
}
