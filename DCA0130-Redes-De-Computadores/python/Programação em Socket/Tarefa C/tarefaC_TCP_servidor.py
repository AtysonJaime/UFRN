# DISCIPLINA: REDES DE COMPUTADORES (DCA0113) - APLICAÇÕES EM SOCKETS COM PYTHON
# AUTOR: ATYSON JAIME DE SOUSA MARTINS
#
# SCRIPT: servidor de sockets TCP mostra a respota ao comando cmd do cliente  (python 3)
#

# importacao das bibliotecas
from socket import * #Socket
import os # blibioteca os

serverName = '' # ip do servidor (em branco)
serverPort = 61000 # porta a se conectar
serverSocket = socket(AF_INET,SOCK_STREAM) # criacao do socket TCP

serverSocket.bind((serverName,serverPort)) #informa o SO a porta e o ip do socket
serverSocket.listen(1) #deixa o socket do servidor pronto para escutar a conexão

print ('Servidor TCP esperando conexoes na porta %d ...' % (serverPort))
while 1:
    connectionSocket, addr= serverSocket.accept()
    comando = connectionSocket.recv(2048)
    comando = comando.decode('utf-8')
    while comando != 'sair':
        print('Servidor recebeu o comando %s do cliente %s' % (comando, addr))
        os.system(comando)
        comando = connectionSocket.recv(2048)
        comando = comando.decode('utf-8')
        if comando == "sair":
            connectionSocket.close()
serverSocket.close() #encerra o socket do servidor