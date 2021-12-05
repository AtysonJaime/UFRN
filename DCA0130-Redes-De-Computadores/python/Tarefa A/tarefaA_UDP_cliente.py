# DISCIPLINA: REDES DE COMPUTADORES (DCA0113) - APLICAÇÕES EM SOCKETS COM PYTHON
# AUTOR: ATYSON JAIME DE SOUSA MARTINS
#
# SCRIPT: Cliente de sockets UDP solicita ao servidor a hora e data no sistema (python 3)
#

# importacao das bibliotecas
from socket import * #Socket

serverName = 'localhost' # ip do cliente
serverPort = 61000 # Escolhemos uma porta entre 1024 e 65535, mas nem todas podem ser selecionadar, 1 ate 1023 estão sendo usados por itens essenciais
clientSocket = socket(AF_INET, SOCK_DGRAM) # criacao do socket UDP -> Define uma rede UDP
comando = input('Digite o comando: ') #
while comando != "sair":
    if comando == 'data':
        clientSocket.sendto(comando.encode('utf-8'),(serverName,serverPort))
        dataHora,serverSocket = clientSocket.recvfrom(2048)
        print('O servidor: %s, respondeu: %s' % (serverSocket, dataHora.decode('utf-8')))
        comando = input('Digite o comando: ') # Solicita o comando novamente
    else:
        print('o termo %s não é aceito comando interno' % (comando))
        comando = input('Digite o comando: ') # Solicita o comando novamente
clientSocket.close()