# DISCIPLINA: REDES DE COMPUTADORES (DCA0113) - APLICAÇÕES EM SOCKETS COM PYTHON
# AUTOR: ATYSON JAIME DE SOUSA MARTINS
#
# SCRIPT: servidor de sockets UDP retornar para o cliente a hora 
# e a dada do sistema a partir da chamada data pelo cliente (python 3)
#

# importacao das bibliotecas
from socket import * #Socket
import time #Time -> Pegar a hora e data

serverName = '' # ip do servidor (em branco) -> se conectar na que estiver livre;
serverPort = 61000 # Escolhemos uma porta entre 1024 e 65535, mas nem todas podem ser selecionadar, 1 ate 1023 estão sendo usados por itens essenciais
serverSocket = socket(AF_INET, SOCK_DGRAM) # criacao do socket UDP -> Define uma rede UDP
serverSocket.bind((serverName, serverPort)) #Indicar ao SO qual o ip e a porta que ira rodar o socket
print ('Servidor UDP esperando conexoes na porta %d ...' % (serverPort))
while 1:
    mensagem, clientAddress = serverSocket.recvfrom(2048) #recebe do cliente a mensagem
    mensagem = mensagem.decode('utf-8')
    horaDataMensagem = str(time.ctime())
    print ('Como solitictado pelo cliente: %s, enviando a data e hora: %s' % (clientAddress, horaDataMensagem))
    serverSocket.sendto(horaDataMensagem.encode('utf-8'), clientAddress)                                                                                                                                                                                                                       
serverSocket.close()