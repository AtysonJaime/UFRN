# Encontra os itens de uma imagem, nesse codigo irá encontrar as bolhas em branco em um fundo preto.
# Procura as bolhas brancas no fundo preto.
# Ao encontrar, alterá o fundo da bolha para o tom de colorido() do incremento usando a função floodFill.
# OBS, no openCV x é coluna e y é linha, mas na nossa convenção x é linha e y é coluna. 
# Portanto, ao passar a semente para a função, passar com os pontos trocados.

import cv2
import sys
import numpy

class Ponto:
    x = 0;
    y = 0;

cv2.namedWindow('Imagem Bolhas', cv2.WINDOW_AUTOSIZE)

# abre imagem bolha.png em colorido.
imgBolhas = cv2.imread("../img/bolhas.png", cv2.IMREAD_COLOR)
if (imgBolhas is None):
    sys.exit("Não conseguimos abrir a imagem.")

# Apresenta Imagem
cv2.namedWindow('Imagem Bolhas', cv2.WINDOW_AUTOSIZE)
cv2.imshow('Imagem Bolhas', imgBolhas)
cv2.waitKey()

# Pega altura e largura da imagem.
altura, largura, n_shape = imgBolhas.shape

# Variaveis
n_bolhas = 0
n_bolhas_buraco = 0
p = Ponto();
colorWhite = numpy.array([255,255,255])
colorBlack = numpy.array([0,0,0])

## Remove as bolhas da borda da imagem
# -> Topo
for i in range(0, largura, 1):
    if (imgBolhas[0,i] == colorWhite).all():
        p.x = i
        p.y = 0
        cv2.floodFill(imgBolhas,None, (p.x,p.y), (0,0,0))
cv2.imshow('Imagem Bolhas', imgBolhas)
cv2.waitKey()

# -> Baixo
for i in range(0, largura, 1):
    if (imgBolhas[altura-1,i] == colorWhite).all():
        p.x = i
        p.y = altura-1
        cv2.floodFill(imgBolhas,None, (p.x,p.y), (0,0,0))
cv2.imshow('Imagem Bolhas', imgBolhas)
cv2.waitKey()

# -> Direita
for j in range(0, altura, 1):
    if (imgBolhas[j,0] == colorWhite).all():
        p.x = 0
        p.y = j
        cv2.floodFill(imgBolhas,None, (p.x,p.y), (0,0,0))
cv2.imshow('Imagem Bolhas', imgBolhas)
cv2.waitKey()

# -> Esquerda
for j in range(0, altura, 1):
    if (imgBolhas[j,largura-1] == colorWhite).all():
        p.x = largura-1
        p.y = j
        cv2.floodFill(imgBolhas,None, (p.x,p.y), (0,0,0))
cv2.imshow('Imagem Bolhas', imgBolhas)
cv2.waitKey()

## Filtra a imagem para calcular quantidade
for i in range(0, altura, 1):
    for j in range(0, largura, 1):
        if (imgBolhas[i,j] == colorWhite).all():
            n_bolhas += 1
            p.x = j
            p.y = i
            if n_bolhas > 255: # -> Resolve o problema da imagem ter mais de 255 objetos na cena.
                colorPoint = (255,(n_bolhas - 255),0)
                cv2.floodFill(imgBolhas,None, (p.x,p.y), colorPoint)
            else:   
                colorPoint = (n_bolhas,0,0)
                cv2.floodFill(imgBolhas,None, (p.x,p.y), colorPoint) 

# Apresenta Imagem Filtrada
cv2.namedWindow('Imagem Filtrada', cv2.WINDOW_AUTOSIZE)
cv2.imshow('Imagem Filtrada', imgBolhas)
cv2.waitKey() 

## Filtra as bolhas com buraco
cv2.floodFill(imgBolhas,None, (0,0), (255,255,255))
for i in range(1, altura, 1):
    for j in range(1, largura, 1):
        if (imgBolhas[i,j] == colorBlack).all():
            p.x = j 
            p.y = i
            ## Quando a bolha tiver um buraco no meio, ficara complemente vermelho, tanto dentro quando fora.
            n_bolhas_buraco += 1
            cv2.floodFill(imgBolhas,None, (p.x,p.y), (0,0,255))
            cv2.floodFill(imgBolhas,None, (p.x-1,p.y-1), (0,0,255))
cv2.namedWindow('Imagem Filtrada', cv2.WINDOW_AUTOSIZE)
cv2.imshow('Imagem Filtrada', imgBolhas)
print("Existem ", n_bolhas, ' bolhas na imagem original')
print("Dessas ", n_bolhas_buraco, ' possuem buracos no meio')

cv2.waitKey()
cv2.destroyAllWindows()
    
