# DISCIPLINA: REDES DE COMPUTADORES (DCA0113) - APLICAÇÕES EM SOCKETS COM PYTHON
# AUTOR: ATYSON JAIME DE SOUSA MARTINS
#
# SCRIPT: cliente em sockets TCP solicita a leitura de um arquivo para o servidor e recebe seu conteudo (python 3)
#

# importacao das bibliotecas
from socket import * #Socket

serverName = 'localhost' # ip do cliente
serverPort = 61000 # porta a se conectar
clientSocket = socket(AF_INET,SOCK_STREAM)
clientSocket.connect((serverName, serverPort)) # Conecta ao socket do servidor

comando = input('Digite o comando: ')
while comando != 'sair':
    listContent = comando.split() #separa a string e as coloca em uma lista
    if listContent[0] == 'obter':
        clientSocket.send(listContent[1].encode('utf-8'))
        dadosArquivos = clientSocket.recv(2048)
        print('O servidor: (\'%s\', %d), respondeu e o conteudo do seu arquivo é' % (serverName, serverPort))
        print('%s' % (dadosArquivos.decode('utf-8')))
        comando = input('Digite o comando: ')
    else:
        print('o termo %s não é aceito como comando interno' % (comando))
        comando = input('Digite o comando: ')
print('%s' % (comando))
clientSocket.send(comando.encode('utf-8'))
clientSocket.close() #encerra o socket do cliente 

