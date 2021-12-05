#include <xc.h>

LIGAR EQU PB0
ADICIONAR EQU PB1
RED EQU PB5,
GREEN EQU PB6,
BLUE EQU PB7,


LDI R16, 0x03
OUT DDRB, R16
Inicio:   
    BST PINB,0
    BRTS LIGAR // Verifica se o botão foi acionado;
    goto $-1
    clt
    OUT PORTB, RED
    


    