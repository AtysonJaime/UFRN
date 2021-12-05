//******************************************************************************
// IMD - Instituto Metropole Digital 
// Disciplina: Projetos de Sistemas RF
// Aula 09: Transmiss�o de dados via protocolo SPI
// Autor: Ellon Paiva Mendes
// Professor Revisor: Heitor Florencio
//
// Este c�digo faz parte da aula pr�tica da disciplina de Projetos de 
// Sistemas RF do Curso T�cnico do Instituto Metropole Digital. 
// O objetivo da aula mostrar como � feita a transmiss�o de dados via protocolo SPI. 
// Este c�digo-fonte cont�m apenas as instru��es a serem gravadas no dispositivo escravo.
//
// ATEN��O: O c�digo neste arquivo est� INCOMPLETO. O objetivo � que os alunos 
// completem os trechos que est�o faltando utilizando o conhecimento da aula. 
// Para instru��es do que deve ser feito, consulte os coment�rios em cada se��o.
// *******************************************************************
// C�digo-fonte baseado no c�digo da aula 8 do PICkit 3. (PIC18F45K20 PICkit 3 
// Debug Express Lesson 8 - Interrupts)
//
// *******************************************************************
// *    Consulte a documenta��o da aula para maiores informa��es!    *
// *******************************************************************

/** B I T S   D E   C O N F I G U R A � � O ******************************/
// As linhas abaixo tratam de inicializar os bits de configura��o do PIC. Esses 
// comandos s�o indicados pela diretiva do compilador "#pragma config". Para a 
// lista de possiveis valores, veja "Help > Topics... > PIC18 Config Settings > 
// PIC18F45K20". Para maiores informa��es, consulte o manual do C18.
#pragma config FOSC = INTIO67, FCMEN = OFF, IESO = OFF
#pragma config PWRT = OFF, BOREN = OFF, BORV = 18
#pragma config MCLRE = ON, LPT1OSC = OFF, PBADEN = OFF, CCP2MX = PORTBE
#pragma config STVREN = ON, LVP = OFF, XINST = OFF
#pragma config CP0 = OFF, CP1 = OFF, CP2 = OFF, CP3 = OFF
#pragma config CPB = OFF, CPD = OFF
#pragma config WRT0 = OFF, WRT1 = OFF, WRT2 = OFF, WRT3 = OFF
#pragma config WRTB = OFF, WRTC = OFF, WRTD = OFF
#pragma config EBTR0 = OFF, EBTR1 = OFF, EBTR2 = OFF, EBTR3 = OFF
#pragma config EBTRB = OFF

/** I N C L U D E S **************************************************/
#include <xc.h>
#include "header_escravo.h"  //cabe�alho com prot�tipos das fun��es do c�digo e algumas defini��es.

/** V A R I A V E I S *************************************************/
// A directiva "#pragma udata" informa ao compilador para declarar vari�veis 
// est�ticas n�o inicializadas. No caso � declarada uma variavel unsigned char
// de nome LED_Display.
#pragma udata   // declara uma variavel n�o inicializada alocada estaticamente 
unsigned char LED_Display;  // unsigned char = vari�vel de 8-bits.

// FUN��O: void main (void): 
// A fun��o "main" apenas chama a fun��o "UserInit()", que � a respons�vel por 
// configurar o PIC da forma que o usu�ro desejar, e depois chama a "UserProcess()" 
// que vai realizar o processamento principal do programa. Note que o 
// "UserProcess()" � chamado dentro de um la�o infinito (o "while(1)"), enquanto o
// "UserInit()" � executado apenas uma vez, no in�cio do programa. O la�o infinito 
// � chamado de la�o principal, e o PIC vai ficar para sempre executando a fun��o 
// "UserProcess()". Para a experiencia, o aluno n�o deve alterar a fun��o main, e 
// sim as fun��es "UserInit()" e "UserProcess()", que ser�o declaradas mais a 
// seguir. L�gico que substituir essas fun��es no main pelo respectivo c�digo 
// tamb�m funcionaria, por�m � uma p�ssima pr�tica de programa��o: isso deixa o 
// c�digo muito desorganizado e dificil de manter. Sempre � indicado dividir as 
// partes do seu programa em fun��es que realizem pequenas tarefas, e ent�o 
// cham�-las na ordem correta. Lembre-se sempre do lema: dividir para conquistar.
void main (void)
{
	UserInit();	

	while(1){
		UserProcess();
	}
}

// FUN��O: void UserInit(void)
// A fun��o UserInit � chamada no come�o do "main" e � onde o aluno deve colocar 
// a rotina de configura��o do PIC. Essa rotina consiste em setar os valores corretos 
// nos registradores do PIC para fazer os modulos funcionarem da forma desejada. 
//
// Nesta experi�ncia, voc� deve configurar o seguinte: 
// 1- Inicializar o valor inicial da vari�vel LED_Display
// 2- Configurar a porta D para funcionar como sa�da digital
// 3- Configurar a porta SPI para funcionar como escravo
// 5- Configurar o PIC para receber a interrup��o da SPI
//
// Realize as adi��es necess�rias no c�digo seguindo as instru��es dos coment�rios 
// abaixo.
void UserInit(void)
{
	
	// 1- A vari�vel LED_Display � onde vamos armazenar o valor a ser mostrado 
	// nos LEDs do circuito, e tamb�m � o valor a ser enviado pela SPI. Defina um 
	// valor inicial que de alguma forma te informe que o PIC esteja funcionando, 
	// ou seja, evite dar o valor zero como valor inicial.
	//Inicialize a vari�vel LED_Display
	LED_Display = 0b1111;       // Mant�m todos os LEDs acesos como configura��o inicial.

	// 2- A porta D est� sendo utilizada para acender os leds no circuito, portanto 
	// seus pinos tem que ser configurados como sa�das digitais. No circuito estamos 
	// utilizando apenas as saidas RD0 a RD3, pois s� estamos utilizando 4 LEDs. Para 
	// definir um pino como sa�da digital, voc� deve limpar o valor do registrador 
	// TRISD relativo ao bit do registrador PORTD que voc� quer que seja a sa�da. 
	// � sempre importante verificar com quais sa�das/entradas um pino do PIC est�
	// multiplexado, e desabilitar aqueles que podem interferir no funcionamento desejado.
	TRISD = 0b00000000;     	// PORTD bits 7:0 are all outputs (0)

	// 3- Aqui voc� vai configurar o m�dulo MSSP para se comunicar atrav�s do procotolo 
	// SPI como um dispositivo escravo. A configura��o � feita de forma semelhante ao 
	// mestre: voc� vai definir valores para os bits dos registradores SSPCON1, SSPSTAT
	// e TRISC. As configura��es tem que estar de acordo com o utilizado no mestre, 
	// principalmente as configura��es relacionadas ao clock: a polaridade e a amostragem 
	// do dado. O modo deve ser corretamente configurado. Para o escravo, existe o modo 
	// que utiliza o SS e o que n�o utiliza o SS. Como a comunica��o � apenas entre um 
	// mestre e escravo, vamos utilizar o modo que n�o depende do SS. Veja no datasheet 
	// como setar corretamente o PIC para funcionar nesse m�dulo. Defina tamb�m o sentido 
	// da informa��o transitando pelos pinos SCK, SDI e SDO. Lembre que agora o escravo 
	// vai receber o clock gerado pelo mestre, logo defina o pino do SCK como entrada. 
	// Por fim, n�o esque�a de habilitar o m�dulo SSP para que ele comece a receber os 
	// dados do mestre.
	
	//Configura o m�dulo MSSP para funcionar como escravo, sem utilizar o Slave Select (SS).
	SSPCON1bits.SSPM3 = 0;
	SSPCON1bits.SSPM2 = 1;
	SSPCON1bits.SSPM1 = 0;
	SSPCON1bits.SSPM0 = 1;
	TRISCbits.TRISC3 = 1; //Configura o pino SCK (que � o RC3) como entrada
	TRISCbits.TRISC4 = 1; //Configura o pino SDI (que � o RC4) como entrada
	TRISCbits.TRISC5 = 0; //Configura o pino SDO (que � o RC5) sa�da
	SSPSTATbits.CKE = 0; //Realiza a transmiss�o quando o clock mudar do estado "idle" para o "active".
	SSPCON1bits.CKP = 0; //Define a polaridade "idle" do clock como sendo zero.
	SSPSTATbits.SMP = 0; //Define para que durante a transmiss�o, seja feita a amostragem do dado no meio do ciclo do clock.
	SSPCON1bits.SSPEN = 1; //Habilita o uso do SPI usando as configura��es acima.
	
	// 4- Por ultimo, voc� deve habilitar as interrup��es que vamos utilizar neste PIC. 
	// No mestre, ativamos a interrup��o INT0, pois estavamos esperando o bot�o ser 
	// pressionado para alterar um dado e envi�-lo pela SPI. No escravo, estamos 
	// interessados em ativar a interrup��o quando um dado for recebido pela SPI. 
	// Para isso, � necess�rio habilitar as interrup��es perif�ricas no bit PEIE do 
	// registrador INTCON, e tamb�m habilitar o bit SSPIE no registrador PIE1. 
	// Lembre-se de limpar a flag de interrup��o do SPI, no bit SSPIF, tamb�m no 
	// registrador PIR1. Neste experimento n�o estamos interessados em trabalhar com as
	// prioridaes de interrup��o, ent�o desabilite-as no bit IPEN do registrador RCON. 
	// Por fim, habilite as interrup��es no bit GIEH do registrador INTCON.

    INTCONbits.PEIE = 1;        // Habilita interrup��es perif�ricas.	
	PIE1bits.SSPIE = 1;         // Habilita interrup��es do SPI
	PIR1bits.SSPIF = 0;         // Limpa o flag de interrup��o da SPI
	RCONbits.IPEN = 0;          // Desliga as prioridades na interrup��o
	INTCONbits.GIEH = 1;        // Liga as interrup��es.

}

// FUN��O: UserProcess
// Nesta fun��o voc� deve colocar a rotina que o PIC vai ficar realizando continuamente, 
// ap�s a inicializa��o. Basicamente, o que deseja � que ele exiba o valor contido na 
// vari�vel LED_Display nos LEDs conectados a porta D. O valor de LED_Display vai ser 
// alterado na interrup��o com o dado recebido do mestre pela SPI. Ou seja, os LEDs deve  
// exibir o que o mestre enviar para o escravo.
void UserProcess(void){
	PORTD = LED_Display; // Coloca o valor de LED_Display nos LEDs do circuito.
}

// -------------------- Rotinas de Servi�o das Interrup��es --------------------------
// FUN��O: InterruptServiceHigh
//
// � nessa fun��o que a m�gica acontece. Ap�s configurar corretamente as interrup��es 
// na fun��o UserInit, sempre que uma interrup��o for gerada o PIC vai parar a 
// execu��o do c�digo atual e iniciar a execu��o desta fun��o.
// Na interrup��o, voc� deve fazer o seguinte:
//
// 1- Verificar qual interrup��o causou a execu��o desta fun��o;
// 2- Limpar o flag da interrup��o
// 3- Atualizar o valor de LED_Display com o valor recebido pela SPI.
void __interrupt() InterruptServiceHigh(void)
{

	// 1- Para verificar qual foi a interrup��o que fez o PIC entrar nesta fun��o, 
	// basta checar o flag das interrup��es que voc� est� trabalhando. Neste exemplo, 
	// estamos trabalhando somente com uma interrup��o, logo n�o � necess�rio verificar 
	// o que interrompeu o PIC. Mas vamos imaginar que temos mais interrup��es ativadas 
	// e vamos realizar sim essa verifica��o. Para isso, basta verificar se o flag da 
	// interrup��o est� igual a 1. No nosso experimento, estamos esperando uma interrup��o
	// do m�dulo MSSP, que � onde a SPI � implementada. Verifique no datasheet onde fica 
	// o bit de flag do m�dulo SSP. Teste se ele � "1", ou seja, se foi o SPI que gerou a 
	// interrup��o. Todo o c�digo de tratamento da interrup��o do SPI deve ficar dentro 
	// deste "if";

	if (PIR1bits.SSPIF) //Verifica se foi uma interrup��o da SPI
    {
		
		// 2- Aqui voc� deve limpar o flag da interrup��o do SPI. Isso indica que a 
		// interrup��o est� sendo tratada. Isso � importante pois se ela n�o for limpa, 
		// e outra interrup��o for gerada, o teste acima indicaria que o SPI gerou a 
		// interrup��o (pois seu flag ainda estaria "1"), quando na verdade foi outra 
		// coisa que interrompeu o PIC. Sempre lembre de limpar as flags de interrup��o 
		// ao trat�-las na sua rotina de interrup��o.
        PIR1bits.SSPIF = 0;

		// 3- Agora � preciso ler o dado recebido e coloc�-lo na vari�vel LED_Display. 
		// Segundo o datasheed do PIC 18F45K20, quando funcionando no modo escravo, a 
		// interrup��o � gerada quando um novo dado recebido est� dispon�vel no buffer 
		// do m�dulo MSSP, ou seja, no registrador SSPBUF. Para retirar o valor de l�, 
		// basta atribu�-lo a vari�vel LED_Display. Isso vai limpar automaticamente os 
		// flags internos do m�dulo MSSP, que indicam que tem um novo pacote. Por�m, o 
		// flag da interrup��o ainda tem que ser limpo manualmente, como voc� deve ter 
		// feito no passo anterior.
		LED_Display = SSPBUF; 

    }

}


