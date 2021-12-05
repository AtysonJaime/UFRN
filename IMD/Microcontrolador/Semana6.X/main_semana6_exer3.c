/*
 * File:   main_semana6_exer3.c
 * Author: Aty
 *
 * Created on 9 de Julho de 2020, 19:20
 */


#include <xc.h>
#include <stdio.h>

void main(void) {
    
    unsigned int x; //Defina aqui o valor da sua variavel e o tipo dela.
    
    printf("Digite o valor de X: ");
    scanf("%d",&x);
    
    if(x > 10) {
        x>>1;
    } else {
        x++;
    }
    
    printf("x = %d", x);    
    return;
}
