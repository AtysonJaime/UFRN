/*
 * File:   main_semana9.c
 * Author: Aty
 *
 * Created on 30 de Julho de 2020, 18:28
 */


#pragma config FOSC = INTIO67
#pragma config PBADEN = OFF // Desliga o conversor AD PORTB
#pragma config PWRT = OFF
#pragma config WDTEN = OFF
#pragma config MCLRE = OFF
#pragma config LVP = OFF

#include <xc.h>

int ciclo = 0; // Pega quantas vezes o timer estorou
int clicoAux = 0; // Começa a contar apos o led 2 ser acionado;
int botaoAcionado = 0; //Dita se o botão foi acionado
int led0FoiAcionado = 0; //Dita se o led 0 foi acionado
int led2FoiAcionado = 0; //Dita se o led 2 foi acionado
int led2Acesso = 0; //Dita se o led 2 está acesso
int led4FoiAcionado = 0; //Dita se o led 4 foi acionado
int led5FoiAcionado = 0; //Dita se o led 5 foi acionado
int led6FoiAcionado = 0; //Dita se o led 6 foi acionado


void configuraTemporizador(){
    OSCCONbits.IRCF = 0b101; // Oscilador interno 4MHz
    
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

void confuguraInterrupcaoExterna(){
    INTCONbits.INT0IE = 1;          // Habilitar interrupção externa INT0
    INTCONbits.INT0IF = 0;          // Limpar flag da interrupção INT0
    INTCON2bits.INTEDG0 = 0;	// Habilitar interrupção INT0 na borda de descida
    RCONbits.IPEN = 0;           		// Desligar todas as prioridades na interrupção.
    INTCONbits.GIE = 1;           		// Habilitar interrupção geral.
}

void __interrupt() interrupcao(){
    if (INTCONbits.INT0IF == 1) {
        botaoAcionado = 1;
        INTCONbits.INT0IF = 0;     // Limpar a flag para detectar uma nova interrupção
    }
    
    if (INTCONbits.TMR0IF == 1){
        //Para questões de arrendodamente do tempo, dado que estamos usando um frequência de 4Mhz:
        // A cada 7 ciclos eu tenho 1 segundo;
        // A cada 4 ciclos eu tenho 0.6segundos;
        if(botaoAcionado == 1){
            ciclo += 1;
            if( ciclo > (7*3) && !led0FoiAcionado) { //3 segundos apos o acionamento do botão
                PORTD = 0b00000001;
                if(ciclo == 7*5){
                    led0FoiAcionado = 1;
                    ciclo = 1; //Nesse caso, na proxima interação ele ja acende o LED 2;
                }
            }
            
            if(led0FoiAcionado) {
                if(ciclo%(7*2) == 0){
                    if(led2Acesso){
                        PORTD &= 0b11111011; //Desliga o LED 2;
                        led2Acesso = 0;
                        led2FoiAcionado = 1;
                    } else {
                        PORTD |= 0b00000100; //Liga o LED 2;
                        led2Acesso = 1;
                    }
                }
            }
            //Quando o Led 2 for acionado e se passar mais 2s
            if(led2FoiAcionado) {
                clicoAux += 1;
                if(clicoAux%4==0){
                    if(!led4FoiAcionado) {
                        PORTD &= 0b00001111; //Apaga LED 7, 6, 5, 4, por precausão
                        PORTD |= 0b00010000; //Acende LED 4
                        led4FoiAcionado = 1;
                    }
                    else if(!led5FoiAcionado){
                        PORTD &= 0b11101111; //Apaga LED 4
                        PORTD |= 0b00100000; //Acende LED 5
                        led5FoiAcionado = 1;
                    }
                    else if(!led6FoiAcionado){
                        PORTD &= 0b11011111; //Apaga LED 5
                        PORTD |= 0b01000000; //Acende LED 6
                        led6FoiAcionado = 1;
                    }
                    else {
                        PORTD &= 0b10111111; //Apaga LED 6
                        PORTD |= 0b10000000; //Acende LED 7
                        led4FoiAcionado = 0;
                        led5FoiAcionado = 0;
                        led6FoiAcionado = 0;
                    }
                }
            }
        }
        INTCONbits.TMR0IF = 0;     //Limpar a flag para detectar a interrupcao por clock
    }
}

void main(void) {
   
    TRISD = 0b00000000; //Ativa os LED RD como saida; 
    TRISB |= 0b00000001;          	// Configurar o bit RB0 como entrada.
    configuraTemporizador(); //chama função para configurar temporizador
    confuguraInterrupcaoExterna(); // chama função para configurar interrupcao externa

    while(1){ 
    }
    return;
}
