## A partir de dois pontos da matriz imagem fornecidos pelo usuario, a região da imagem deve ficar negativo;

import cv2
import sys

def negativa_img(value):
    return 255 - value


cv2.namedWindow('Show Imagem', cv2.WINDOW_AUTOSIZE)

# abre imagem bolha.png em preto e branco.
img = cv2.imread("biel.png", cv2.IMREAD_GRAYSCALE)
if (img is None):
    sys.exit("Não conseguimos abrir a imagem.")
print(img)
p1 = [0,0]
p2 = [0,0]
print(type(p1[0]),p2)
p1[0] = int(input("Digite a posição x do ponto 1: "))
while ((p1[0] < 0) or (p1[0] > 255)):
    print('Valor invalido para posição x \n')
    p1[0] = int(input("Digite a posição x do ponto 1: "))

p1[1] = int(input("Digite a posição y do ponto 1: "))
while ((p1[1] < 0) or (p1[1] > 255)):
    print('Valor invalido para posição y \n')
    p1[1] = int(input("Digite a posição y do ponto 1: "))

p2[0] = int(input("Digite a posição x do ponto 2: "))
while ((p2[0] < p1[0]) or (p2[0] > 255)):
    print('Valor invalido para posição x \n')
    p2[0] = int(input("Digite a posição x do ponto 2: "))

p2[1] = int(input("Digite a posição y do ponto 2: "))
while ((p2[1] < p1[1]) or (p2[1] > 255)):
    print('Valor invalido para posição y \n')
    p2[1] = int(input("Digite a posição y do ponto 2: "))

print('Pontos 01: \n')
print("x >> ", p1[0], '\ny >>>> ', p1[1])
print('\nPontos 02: \n')
print("x >> ", p2[0], '\ny >>>> ', p2[1])

cv2.imshow('Show Imagem', img)
cv2.waitKey(0)

print('Deixando negativo a região entre os dois pontos dados')
for i in range(p1[0], p2[0], 1):
    for j in range(p1[1], p2[1], 1):
        img[i,j] = negativa_img(img[i,j])

cv2.imshow('Negativo Imagem', img)
cv2.waitKey(0)
cv2.destroyAllWindows()