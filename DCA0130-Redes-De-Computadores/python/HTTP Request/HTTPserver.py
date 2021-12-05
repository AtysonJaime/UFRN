# importacao das bibliotecas
import socket
import os.path
from os import path #Biblbioteca para saber se aquele arquivo existe no projeto

# definicao do host e da porta do servidor
HOST = '' # ip do servidor (em branco)
PORT = 8080 # porta do servidor

# cria o socket com IPv4 (AF_INET) usando TCP (SOCK_STREAM)
listen_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# permite que seja possivel reusar o endereco e porta do servidor caso seja encerrado incorretamente
listen_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

# vincula o socket com a porta (faz o "bind" do IP do servidor com a porta)
listen_socket.bind((HOST, PORT))

# "escuta" pedidos na porta do socket do servidor
listen_socket.listen(1)

# imprime que o servidor esta pronto para receber conexoes
print ('Serving HTTP on port %s ...' % PORT)

newConnetion = True

while True:
    # aguarda por novas conexoes
    if newConnetion == True:
        client_connection, client_address = listen_socket.accept()
    
    # o metodo .recv recebe os dados enviados por um cliente atraves do socket
    request = client_connection.recv(1024)
    # imprime na tela o que o cliente enviou ao servidor
    print (request.decode('utf-8'))
    if (len(request) > 0):
        result = request.decode('utf-8').split()

        if result[0] == 'GET': #Solicitações quando o get é acionado
            content = result[1]
            
            if  path.exists(content[1:]):
                http_response = "HTTP/1.1 200 OK\r\n\r\n"
                client_connection.send(http_response.encode('utf-8'))
                client_connection.send((open(content[1:],'rb').read()))
            elif content == '/':
                http_response = "HTTP/1.1 200 OK\r\n\r\n" + open('index.html','r',encoding='utf-8').read()
                client_connection.send(http_response.encode('utf-8'))
            else:
                http_response = "HTTP/1.1 404 Not Found\r\n\r\n" + open('error/not_found_404.html','r',encoding='utf-8').read()
                client_connection.send(http_response.encode('utf-8'))
            newConnetion = True
            client_connection.close()
        else: #Solicitações onde não foi usado o GET
            http_response = "HTTP/1.1 400 Bad Request\r\n\r\n" + open('error/bad_request_400.html','r',encoding='utf-8').read() + "\r\n"
            client_connection.send(http_response.encode('utf-8'))
            newConnetion = False
# encerra o socket do servidor
listen_socket.close()