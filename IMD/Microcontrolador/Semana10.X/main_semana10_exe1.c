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

#include <xc.h>

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

void main(void) {
    OSCCONbits.IRCF = 0b110; // Configurar oscilador interno para 4MHz
    
    configuraConversorAD();
    
    TRISD = 0; //Configura todos os pinos D para saida
    int valueAD = 0;
    
    while(1) {
        ADCON0bits.GO = 1; // Iniciar conversão
		while (ADCON0bits.GO){};  // Esperar a conversão finalizar
		valueAD = (ADRESH << 8) + ADRESL;
 
        if(valueAD < 310) {
            if(valueAD < 31) {
                PORTD = 0;
            }else if(valueAD >= 31 && valueAD < 62) {
                PORTD = 1;
            } else if (valueAD >= 62 && valueAD < 93) {
                PORTD = 2;
            }else if (valueAD >= 93 && valueAD < 124) {
                PORTD = 3;
            }else if (valueAD >= 124 && valueAD < 155) {
                PORTD = 4;
            }else if (valueAD >= 155 && valueAD < 186) {
                PORTD = 5;
            }else if (valueAD >= 186 && valueAD < 217) {
                PORTD = 6;
            }else if (valueAD >= 217 && valueAD < 248) {
                PORTD = 7;
            }else if (valueAD >= 248 && valueAD < 279) {
                PORTD = 8;
            }else if(valueAD >= 279 && valueAD < 309) {
                PORTD = 9;
            }
        } else if(valueAD >= 310 && valueAD < 620) {
            PORTD = 0b00010000;
            if(valueAD < 310) {
                PORTD |= 0;
            }else if(valueAD >= 341 && valueAD < 372) {
                PORTD |= 1;
            } else if (valueAD >= 372 && valueAD < 403) {
                PORTD |= 2;
            }else if (valueAD >= 403 && valueAD < 434) {
                PORTD |= 3;
            }else if (valueAD >= 434 && valueAD < 465) {
                PORTD |= 4;
            }else if (valueAD >= 465 && valueAD < 496) {
                PORTD |= 5;
            }else if (valueAD >= 496 && valueAD < 527) {
                PORTD |= 6;
            }else if (valueAD >= 527 && valueAD < 558) {
                PORTD |= 7;
            }else if (valueAD >= 558 && valueAD < 589) {
                PORTD |= 8;
            }else {
                PORTD |= 9;
            }
        } else if(valueAD >= 620 && valueAD < 930) {
            PORTD = 0b00100000;
            if(valueAD < 620) {
                PORTD |= 0;
            }else if(valueAD >= 651 && valueAD < 682) {
                PORTD |= 1;
            } else if (valueAD >= 372 && valueAD < 713) {
                PORTD |= 2;
            }else if (valueAD >= 713 && valueAD < 744) {
                PORTD |= 3;
            }else if (valueAD >= 744 && valueAD < 775) {
                PORTD |= 4;
            }else if (valueAD >= 775 && valueAD < 806) {
                PORTD |= 5;
            }else if (valueAD >= 806 && valueAD < 837) {
                PORTD |= 6;
            }else if (valueAD >= 837 && valueAD < 868) {
                PORTD |= 7;
            }else if (valueAD >= 868 && valueAD < 899) {
                PORTD |= 8;
            }else {
                PORTD |= 9;
            }
        } else {
            PORTD = 0b00110000;
            if(valueAD < 930) {
                PORTD |= 0;
            }else if(valueAD >= 961 && valueAD < 992) {
                PORTD |= 1;
            } else if (valueAD >= 992 && valueAD < 1023) {
                PORTD |= 2;
            }else {
                PORTD |= 3;
            }
        };
    }
    
    return;
}
