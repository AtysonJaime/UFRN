# DISCIPLINA: REDES DE COMPUTADORES (DCA0113) - APLICAÇÕES EM SOCKETS COM PYTHON
# AUTOR: ATYSON JAIME DE SOUSA MARTINS
#
# SCRIPT: cliente em sockets TCP envia ao servidor um comando cmd (python 3)
#

# importacao das bibliotecas
from socket import * #Socket

serverName = 'localhost' # ip do cliente
serverPort = 61000 # porta a se conectar
clientSocket = socket(AF_INET,SOCK_STREAM)
clientSocket.connect((serverName, serverPort)) # Conecta ao socket do servidor
comando = input('Digite o comando: ')
while comando != 'sair': # Necessario para ficar pedindo comendo ao terminal
    clientSocket.send(comando.encode('utf-8'))
    comando = input('Digite o comando: ')
clientSocket.send(comando.encode('utf-8'))
clientSocket.close() #encerra o socket do cliente 

