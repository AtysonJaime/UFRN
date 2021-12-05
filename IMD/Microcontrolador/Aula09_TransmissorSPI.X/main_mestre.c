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
// Este c�digo-fonte cont�m apenas as instru��es a serem gravadas no dispositivo mestre. 
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
#pragma config WDTEN = OFF, WDTPS = 32768                                     
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
#include "header_mestre.h"  //cabe�alho com prot�tipos das fun��es do c�digo e algumas defini��es.

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
// 3- Configurar o pino RB0 como entrada digital
// 4- Configurar a porta SPI para funcionar como mestre
// 5- Configurar o PIC para receber a interrup��o INT2
//
// Realize as adi��es necess�rias no c�digo seguindo as instru��es dos coment�rios 
// abaixo.
 void UserInit(void)
{

	// 1- A vari�vel LED_Display � onde vamos armazenar o valor a ser mostrado 
	// nos LEDs(DS1, DS2, DS3 e DS4) da placa (Demo Board do PICKIT3), e tamb�m 
	// � o valor a ser enviado pela SPI. Defina um valor inicial que de alguma 
	// forma te informe que o PIC esteja funcionando, ou seja, evite dar o valor
	// zero como valor inicial.
	LED_Display = 0b0001;   // Acende o primeiro LED como condi��o inicial.

	// 2- A porta D est� sendo utilizada para acender os leds no circuito da placa, portanto 
	// seus pinos tem que ser configurados como sa�das digitais. No microcontrolador estamos 
	// utilizando apenas os pinos RD0 a RD3, pois s� estamos utilizando 4 LEDs da placa. 
	// Para definir um pino como sa�da digital, voc� deve limpar o valor do registrador 
	// TRISD relativo ao bit do registrador PORTD que voc� quer que seja a sa�da. 
	// � sempre importante verificar com quais sa�das/entradas um pino do PIC est�
	// multiplexado, e desabilitar aqueles que podem interferir no funcionamento desejado.
	TRISD = 0b00000000;     	// PORTD bits 7:0 are all outputs (0)

	// 3- O bot�o da placa est� conectado a porta RB0 do PIC, logo essa porta tem 
	// que ser configurada como uma entrada digital. Isso pode ser feito alterando o 
	// valor do bit TRISB0 do registrador TRISB: 0 indica sa�da; 1 indica entrada. 
	TRISB = 1;       // PORTB bit 0 (connected to switch) is input (1)

	// 4- Aqui voc� vai precisar programar o funcionamento do m�dulo MSSP para 
	// funcionar com uma comunica��o SPI. Para isso, voc� vai ter que alterar os valores 
	// dos registradores SSPSTAT e SSPCON1. � importante setar esses valores corretamente 
	// e de acordo com o c�digo do dispositivo escravo, sen�o a comunica��o n�o vai 
	// ocorrer. Voc� deve definir o modo de opera��o da SPI nos bits SSPM<3:0> (bits SSPM 
	// de 3 a 0) do registrador SSPCON1. Veja no datasheet como colocar o PIC para trabalhar 
	// como MESTRE, utilizando um clock igual a frequencia de oscila��o dividido por 4 (FOSC/4).
	// Temos que definir como ser� o clock gerado pelo mestre. Isso � feito nos bits CKE e SMP 
	// do registrador SSPSTAT, e no CKP do registrador SSPCON1. Veja no datasheet como 
	// configurar o SPI para transmitir quando o clock mudar para "ativo", como colocar 
	// a polaridade "idle" do clock para 0V, e como configurar para o dado ser amostrado no
	// meio do pulso de clock. Veja no datasheet onde est�o os pinos SDI, SDO e SCK 
	// e com quais bits da porta C eles est�o multiplexados. Voc� deve ent�o definir o 
	// sentido que os dados v�o transitar nessas portas. SDO � a saida do SPI, logo ela deve
	// ser configurada como sa�da. SDI � a entrada do SPI, logo ela tem que ser entrada. E 
	// como esse PIC � o mestre da comunica��o SPI, estamos gerando o sinal de clock e 
	// portanto esse pino deve ser configurado como sa�da. Essas configura��es s�o feitas nos 
	// bits do registrador TRISC relativos aos bits destas portas que est�o 
	// multiplexados com os sinais do SPI. Por fim, inicie o funcionamento do SPI atrav�s do 
	// bit SSPEN do registrador SSPCON1. Lembre-se que o Escravo tem que estar configurado 
	// de acordo com o Meste para a comunica��o acontecer! 

	//Seta o modo de opera��o da SPI: Master mode, com o clock sendo FOSC/4.
	SSPCON1bits.SSPM3 = 0; 
	SSPCON1bits.SSPM2 = 0;
	SSPCON1bits.SSPM1 = 0;
	SSPCON1bits.SSPM0 = 0;
	TRISCbits.TRISC3 = 0; //Configura o pino SCK (que � o RC3) como sa�da
	TRISCbits.TRISC4 = 1; //Configura o pino SDI (que � o RC4) como entrada
	TRISCbits.TRISC5 = 0; //Configura o pino SDO (que � o RC5) sa�da
	SSPSTATbits.CKE = 0; //Realiza a transmiss�o quando o clock mudar do estado "idle" para o "active".
	SSPCON1bits.CKP = 0; //Define a polaridade "idle" do clock como sendo zero.
	SSPSTATbits.SMP = 0; //Define para que durante a transmiss�o, seja feita a amostragem do dado no meio do ciclo do clock.
	SSPCON1bits.SSPEN = 1; //Habilita o uso do SPI usando as configura��es acima.
	
	// 5- Para configurar corretamente as interrup��es (INT0, INT1 ou INT2), voc� deve alterar os registradores 
	// INTCON, INTCON2 e INTCON3. A entrada RB0 gera a interrup��o INT0, portanto voc� 
	// deve habilit�-la no bit INT0IE no registrador INTCON. � interessante limpar a flag
	// do INT0 para garantir que ela vai come�ar em zero (bit INT0IF do registrador INTCON).
	// Observe o circuito da placa (demo board) seguindo as orienta��es na aula. Quando o bot�o � 
	// pressionado, aplicamos 0V no RB0, voltando a 5V ao liberar o bot�o. Queremos que a 
	// interrup��o seja gerada no momento que pressionamos o bot�o, ou seja, quando o sinal 
	// muda de "1" para "0". Isso � informado no bit INTEDG0 do registrador INTCON2. � 
	// importante habilitar tamb�m os resistores de "pull ups" internos para a porta B. 
	// Isso � feito no bit RBPU do registrador INTCON2. Nesse experimento, n�o estamos 
	// utilizando prioridades de interrup��o: todas as interrup��es geradas ser�o de alta 
	// prioridade. Por isso, desabilite as prioridades no bit IPEN no registrador RCON.
	// Mesmo que quis�ssemos n�o seria poss�vel definir uma alta prioridade para a interrup��o INT0
	// porque n�o existe prioridade para o INT0 no PIC18F45K20 (Observe essa informa��o no datasheet).
	// Por fim, habilite o PIC para capturar as interrup��es setando o bit GIEH do registrador 
	// INTCON.
	INTCONbits.INT0IE = 1;          // Habilitar interrup��o externa INT0
    INTCONbits.INT0IF = 0;          // Limpar flag da interrup��o INT0
    INTCON2bits.INTEDG0 = 0;	// Habilitar interrup��o INT0 na borda de descida
    RCONbits.IPEN = 0;           		// Desligar todas as prioridades na interrup��o.
    INTCONbits.GIE = 1;         // Interrupting enabled.

}

// FUN��O: UserProcess
// Nesta fun��o voc� deve colocar a rotina que o PIC vai ficar realizando continuamente, 
// ap�s a inicializa��o. Basicamente, o que deseja � que ele exiba o valor contido na 
// vari�vel LED_Display nos LEDs conectados a porta D. Voc� n�o deve tratar o acionamento 
// do bot�o ou o envio pela SPI aqui, j� que desejamos fazer isso atrav�s de uma rotina 
// de interrup��o. 
void UserProcess(void){
	PORTD = LED_Display; //Coloca a sa�da na Demo Board
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
// 3- Atualizar o valor da variavel LED_Display;
// 4- Transmitir o valor de LED_Display pela SPI;
void __interrupt() InterruptServiceHigh(void)
{
    // 1- Para verificar qual foi a interrup��o que fez o PIC entrar nesta fun��o, 
	// basta checar o flag das interrup��es que voc� est� trabalhando. Neste exemplo, 
	// estamos trabalhando somente com uma interrup��o, logo n�o � necess�rio verificar 
	// o que interrompeu o PIC. Mas vamos imaginar que temos mais interrup��es ativadas 
	// e vamos realizar sim essa verifica��o. Para isso, basta verificar se o flag da 
	// interrup��o est� igual a 1. No nosso experimento, estamos utilizando a interrup��o 
	// INT0. Verifique no datasheet onde fica a bit de flag do INT0 e fa�a um "if" 
	// testando se ela � igual a "1". Todo o c�digo de tratamento desta interrup��o deve 
	// ficar dentro deste "if".
    if (INTCONbits.INT0IF == 1) //Verifica se o INT0 interrompeu o PIC.
    {
		// 2- Aqui voc� deve limpar o flag da interrup��o INT0. Isso indica que a 
		// interrup��o est� sendo tratada. Isso � importante pois se ela n�o for limpa, 
		// e outra interrup��o for gerada, o teste acima indicaria que INT0 gerou a 
		// interrup��o (pois seu flag ainda estaria "1"), quando na verdade foi outra 
		// coisa que interrompeu o PIC. Sempre lembre de limpar as flags de interrup��o 
		// ao trat�-las na sua rotina de interrup��o.
       
        PORTD = 0b10000000;
		// 3- Aqui voc� deve atualizar o valor de LED_Display. Perceba que a interrup��o 
		// ser� gerada quando pressionarmos o bot�o na placa (demo board). Portanto essa atualiza��o
		// s� ser� feita quando o bot�o for pressionado. Lembre-se que ao sair da rotina 
		// de interrup��o a rotina principal vai atualizar o valor dos LEDs baseado no 
		// valor da vari�vel LED_Display. Note tamb�m que temos apenas 4 LEDs (DS1-RD0,
		// DS2-RD1, DS3-RD2 e DS4-RD3) e a variavel LED_Display tem 8 bits. Logo, somente 
		// 4 bits realmente ser�o transformados em acionamento dos LEDs. Tome cuidado 
		// para n�o gerar uma atualiza��o que mude somente bits que n�o ser�o vis�veis nos LEDs.
		LED_Display = LED_Display << 1; //Desloca o valor do LED_Display uma vez para a esquerda.

		if(LED_Display == 0b10000){ //Verifica se o bit "1" saiu do escopo dos 4 leds da placa.
			LED_Display = 1; //Se saiu, volta a vari�vel LED_Display para o valor inicial.
		}

		// 4- Para transmitir o dado pela SPI basta escrever o dado no buffer 
		// SSPBUF. Desde que a SPI esteja corretamente configurada, o m�dulo MSSP vai 
		// iniciar a transmiss�o do dado. Note que o dado vai tomar um certo tempo para
		// ser transmitido, por�m o programa vai continuar executando as outras linhas 
		// do c�digo. Logo, pode acontecer de um dado ser enviado pela SPI e antes de 
		// ele terminar de ser transmitido, o PIC tentar enviar outro dado, escrevendo 
		// novamente no SSPBUF. Isso tamb�m pode acontecer caso voc� deseje enviar mais 
		// de um byte pela SPI. Uma forma simples de contornar esse problema � monitorar 
		// o bit SSPIF do registrador PIR1. Durante a transmiss�o, esse bit permanecer� 
		// setado, indicando que existe uma transmiss�o em andamento. Assim que a 
		// transmiss�o terminar, o PIC vai limpar o valor desse bit. Um c�digo simples 
		// de espera ocupada faz com que o c�digo fique parado esperando a transmiss�o 
		// terminar para executar as demais linhas do codigo. Outros testes podem ser 
		// feitos verificando os respectivos bits (como por exemplo, verificar se houve 
		// colis�o durante a transmiss�o), mas em uma experi�ncia simples como esta isso 
		// n�o deve ocorrer. Portanto escrever o valor de LED_Display no registrador 
		// SSPBUF deve ser suficiente.
		SSPBUF = LED_Display; //Escreve o dado no buffer de transmiss�o.
        
        INTCONbits.INT0IF = 0; //Limpa o flag de interrup��o do INT0.
  		
    }

    
}  
