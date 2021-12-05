//******************************************************************************
// IMD - Instituto Metropole Digital 
// Disciplina: Projetos de Sistemas RF
// Aula 09: Transmissão de dados via protocolo SPI
// Autor: Ellon Paiva Mendes
// Professor Revisor: Heitor Florencio
//
// Este código faz parte da aula prática da disciplina de Projetos de 
// Sistemas RF do Curso Técnico do Instituto Metropole Digital. 
// O objetivo da aula mostrar como é feita a transmissão de dados via protocolo SPI. 
// Este código-fonte contém apenas as instruções a serem gravadas no dispositivo escravo.
//
// ATENÇÃO: O código neste arquivo está INCOMPLETO. O objetivo é que os alunos 
// completem os trechos que estão faltando utilizando o conhecimento da aula. 
// Para instruções do que deve ser feito, consulte os comentários em cada seção.
// *******************************************************************
// Código-fonte baseado no código da aula 8 do PICkit 3. (PIC18F45K20 PICkit 3 
// Debug Express Lesson 8 - Interrupts)
//
// *******************************************************************
// *    Consulte a documentação da aula para maiores informações!    *
// *******************************************************************

/** B I T S   D E   C O N F I G U R A Ç Ã O ******************************/
// As linhas abaixo tratam de inicializar os bits de configuração do PIC. Esses 
// comandos são indicados pela diretiva do compilador "#pragma config". Para a 
// lista de possiveis valores, veja "Help > Topics... > PIC18 Config Settings > 
// PIC18F45K20". Para maiores informações, consulte o manual do C18.
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
#include "header_escravo.h"  //cabeçalho com protótipos das funções do código e algumas definições.

/** V A R I A V E I S *************************************************/
// A directiva "#pragma udata" informa ao compilador para declarar variáveis 
// estáticas não inicializadas. No caso é declarada uma variavel unsigned char
// de nome LED_Display.
#pragma udata   // declara uma variavel não inicializada alocada estaticamente 
unsigned char LED_Display;  // unsigned char = variável de 8-bits.

// FUNÇÃO: void main (void): 
// A função "main" apenas chama a função "UserInit()", que é a responsável por 
// configurar o PIC da forma que o usuáro desejar, e depois chama a "UserProcess()" 
// que vai realizar o processamento principal do programa. Note que o 
// "UserProcess()" é chamado dentro de um laço infinito (o "while(1)"), enquanto o
// "UserInit()" é executado apenas uma vez, no início do programa. O laço infinito 
// é chamado de laço principal, e o PIC vai ficar para sempre executando a função 
// "UserProcess()". Para a experiencia, o aluno não deve alterar a função main, e 
// sim as funções "UserInit()" e "UserProcess()", que serão declaradas mais a 
// seguir. Lógico que substituir essas funções no main pelo respectivo código 
// também funcionaria, porém é uma péssima prática de programação: isso deixa o 
// código muito desorganizado e dificil de manter. Sempre é indicado dividir as 
// partes do seu programa em funções que realizem pequenas tarefas, e então 
// chamá-las na ordem correta. Lembre-se sempre do lema: dividir para conquistar.
void main (void)
{
	UserInit();	

	while(1){
		UserProcess();
	}
}

// FUNÇÃO: void UserInit(void)
// A função UserInit é chamada no começo do "main" e é onde o aluno deve colocar 
// a rotina de configuração do PIC. Essa rotina consiste em setar os valores corretos 
// nos registradores do PIC para fazer os modulos funcionarem da forma desejada. 
//
// Nesta experiência, você deve configurar o seguinte: 
// 1- Inicializar o valor inicial da variável LED_Display
// 2- Configurar a porta D para funcionar como saída digital
// 3- Configurar a porta SPI para funcionar como escravo
// 5- Configurar o PIC para receber a interrupção da SPI
//
// Realize as adições necessárias no código seguindo as instruções dos comentários 
// abaixo.
void UserInit(void)
{
	
	// 1- A variável LED_Display é onde vamos armazenar o valor a ser mostrado 
	// nos LEDs do circuito, e também é o valor a ser enviado pela SPI. Defina um 
	// valor inicial que de alguma forma te informe que o PIC esteja funcionando, 
	// ou seja, evite dar o valor zero como valor inicial.
	//Inicialize a variável LED_Display
	LED_Display = 0b1111;       // Mantém todos os LEDs acesos como configuração inicial.

	// 2- A porta D está sendo utilizada para acender os leds no circuito, portanto 
	// seus pinos tem que ser configurados como saídas digitais. No circuito estamos 
	// utilizando apenas as saidas RD0 a RD3, pois só estamos utilizando 4 LEDs. Para 
	// definir um pino como saída digital, você deve limpar o valor do registrador 
	// TRISD relativo ao bit do registrador PORTD que você quer que seja a saída. 
	// É sempre importante verificar com quais saídas/entradas um pino do PIC está
	// multiplexado, e desabilitar aqueles que podem interferir no funcionamento desejado.
	TRISD = 0b00000000;     	// PORTD bits 7:0 are all outputs (0)

	// 3- Aqui você vai configurar o módulo MSSP para se comunicar através do procotolo 
	// SPI como um dispositivo escravo. A configuração é feita de forma semelhante ao 
	// mestre: você vai definir valores para os bits dos registradores SSPCON1, SSPSTAT
	// e TRISC. As configurações tem que estar de acordo com o utilizado no mestre, 
	// principalmente as configurações relacionadas ao clock: a polaridade e a amostragem 
	// do dado. O modo deve ser corretamente configurado. Para o escravo, existe o modo 
	// que utiliza o SS e o que não utiliza o SS. Como a comunicação é apenas entre um 
	// mestre e escravo, vamos utilizar o modo que não depende do SS. Veja no datasheet 
	// como setar corretamente o PIC para funcionar nesse módulo. Defina também o sentido 
	// da informação transitando pelos pinos SCK, SDI e SDO. Lembre que agora o escravo 
	// vai receber o clock gerado pelo mestre, logo defina o pino do SCK como entrada. 
	// Por fim, não esqueça de habilitar o módulo SSP para que ele comece a receber os 
	// dados do mestre.
	
	//Configura o módulo MSSP para funcionar como escravo, sem utilizar o Slave Select (SS).
	SSPCON1bits.SSPM3 = 0;
	SSPCON1bits.SSPM2 = 1;
	SSPCON1bits.SSPM1 = 0;
	SSPCON1bits.SSPM0 = 1;
	TRISCbits.TRISC3 = 1; //Configura o pino SCK (que é o RC3) como entrada
	TRISCbits.TRISC4 = 1; //Configura o pino SDI (que é o RC4) como entrada
	TRISCbits.TRISC5 = 0; //Configura o pino SDO (que é o RC5) saída
	SSPSTATbits.CKE = 0; //Realiza a transmissão quando o clock mudar do estado "idle" para o "active".
	SSPCON1bits.CKP = 0; //Define a polaridade "idle" do clock como sendo zero.
	SSPSTATbits.SMP = 0; //Define para que durante a transmissão, seja feita a amostragem do dado no meio do ciclo do clock.
	SSPCON1bits.SSPEN = 1; //Habilita o uso do SPI usando as configurações acima.
	
	// 4- Por ultimo, você deve habilitar as interrupções que vamos utilizar neste PIC. 
	// No mestre, ativamos a interrupção INT0, pois estavamos esperando o botão ser 
	// pressionado para alterar um dado e enviá-lo pela SPI. No escravo, estamos 
	// interessados em ativar a interrupção quando um dado for recebido pela SPI. 
	// Para isso, é necessário habilitar as interrupções periféricas no bit PEIE do 
	// registrador INTCON, e também habilitar o bit SSPIE no registrador PIE1. 
	// Lembre-se de limpar a flag de interrupção do SPI, no bit SSPIF, também no 
	// registrador PIR1. Neste experimento não estamos interessados em trabalhar com as
	// prioridaes de interrupção, então desabilite-as no bit IPEN do registrador RCON. 
	// Por fim, habilite as interrupções no bit GIEH do registrador INTCON.

    INTCONbits.PEIE = 1;        // Habilita interrupções periféricas.	
	PIE1bits.SSPIE = 1;         // Habilita interrupções do SPI
	PIR1bits.SSPIF = 0;         // Limpa o flag de interrupção da SPI
	RCONbits.IPEN = 0;          // Desliga as prioridades na interrupção
	INTCONbits.GIEH = 1;        // Liga as interrupções.

}

// FUNÇÃO: UserProcess
// Nesta função você deve colocar a rotina que o PIC vai ficar realizando continuamente, 
// após a inicialização. Basicamente, o que deseja é que ele exiba o valor contido na 
// variável LED_Display nos LEDs conectados a porta D. O valor de LED_Display vai ser 
// alterado na interrupção com o dado recebido do mestre pela SPI. Ou seja, os LEDs deve  
// exibir o que o mestre enviar para o escravo.
void UserProcess(void){
	PORTD = LED_Display; // Coloca o valor de LED_Display nos LEDs do circuito.
}

// -------------------- Rotinas de Serviço das Interrupções --------------------------
// FUNÇÃO: InterruptServiceHigh
//
// É nessa função que a mágica acontece. Após configurar corretamente as interrupções 
// na função UserInit, sempre que uma interrupção for gerada o PIC vai parar a 
// execução do código atual e iniciar a execução desta função.
// Na interrupção, você deve fazer o seguinte:
//
// 1- Verificar qual interrupção causou a execução desta função;
// 2- Limpar o flag da interrupção
// 3- Atualizar o valor de LED_Display com o valor recebido pela SPI.
void __interrupt() InterruptServiceHigh(void)
{

	// 1- Para verificar qual foi a interrupção que fez o PIC entrar nesta função, 
	// basta checar o flag das interrupções que você está trabalhando. Neste exemplo, 
	// estamos trabalhando somente com uma interrupção, logo não é necessário verificar 
	// o que interrompeu o PIC. Mas vamos imaginar que temos mais interrupções ativadas 
	// e vamos realizar sim essa verificação. Para isso, basta verificar se o flag da 
	// interrupção está igual a 1. No nosso experimento, estamos esperando uma interrupção
	// do módulo MSSP, que é onde a SPI é implementada. Verifique no datasheet onde fica 
	// o bit de flag do módulo SSP. Teste se ele é "1", ou seja, se foi o SPI que gerou a 
	// interrupção. Todo o código de tratamento da interrupção do SPI deve ficar dentro 
	// deste "if";

	if (PIR1bits.SSPIF) //Verifica se foi uma interrupção da SPI
    {
		
		// 2- Aqui você deve limpar o flag da interrupção do SPI. Isso indica que a 
		// interrupção está sendo tratada. Isso é importante pois se ela não for limpa, 
		// e outra interrupção for gerada, o teste acima indicaria que o SPI gerou a 
		// interrupção (pois seu flag ainda estaria "1"), quando na verdade foi outra 
		// coisa que interrompeu o PIC. Sempre lembre de limpar as flags de interrupção 
		// ao tratá-las na sua rotina de interrupção.
        PIR1bits.SSPIF = 0;

		// 3- Agora é preciso ler o dado recebido e colocá-lo na variável LED_Display. 
		// Segundo o datasheed do PIC 18F45K20, quando funcionando no modo escravo, a 
		// interrupção é gerada quando um novo dado recebido está disponível no buffer 
		// do módulo MSSP, ou seja, no registrador SSPBUF. Para retirar o valor de lá, 
		// basta atribuí-lo a variável LED_Display. Isso vai limpar automaticamente os 
		// flags internos do módulo MSSP, que indicam que tem um novo pacote. Porém, o 
		// flag da interrupção ainda tem que ser limpo manualmente, como você deve ter 
		// feito no passo anterior.
		LED_Display = SSPBUF; 

    }

}


