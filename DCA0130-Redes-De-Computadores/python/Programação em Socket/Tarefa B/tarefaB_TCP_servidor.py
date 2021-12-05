# DISCIPLINA: REDES DE COMPUTADORES (DCA0113) - APLICAÇÕES EM SOCKETS COM PYTHON
# AUTOR: ATYSON JAIME DE SOUSA MARTINS
#
# SCRIPT: servidor de sockets TCP retornar a leitura de um arquivo para o cliente (python 3)
#

# importacao das bibliotecas
from socket import * #Socket

serverName = '' # ip do servidor (em branco)
serverPort = 61000 # porta a se conectar
serverSocket = socket(AF_INET,SOCK_STREAM) # criacao do socket TCP

serverSocket.bind((serverName,serverPort)) #informa o SO a porta e o ip do socket
serverSocket.listen(1) #deixa o socket do servidor pronto para escutar a conexão

print ('Servidor TCP esperando conexoes na porta %d ...' % (serverPort))
stop = False
while 1:
    connectionSocket, addr= serverSocket.accept() 
    while stop != True:
        arquivo = connectionSocket.recv(2048)
        arquivo = arquivo.decode('utf-8')
        if arquivo != 'sair':
            contentArquivo = open(arquivo).read()
            print('Enviando ao cliente: %s, o conteudo do arquivo %s' % (addr,arquivo))
            connectionSocket.send(contentArquivo.encode('utf-8'))
        else:
            stop = True 
    connectionSocket.close() #encerrar o socket com o cliente
serverSocket.close() #encerra o socket do servidor