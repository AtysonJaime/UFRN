## A partir de dois pontos da matriz imagem fornecidos pelo usuario, a região da imagem deve ficar negativo;

import cv2
import sys

def negativa_img(value):
    return 255 - value

cv2.namedWindow('Imagem Normal', cv2.WINDOW_AUTOSIZE)
cv2.namedWindow('Imagem Negativa', cv2.WINDOW_AUTOSIZE)

# abre imagem bolha.png em preto e branco.
img = cv2.imread("../img/biel.png", cv2.IMREAD_GRAYSCALE)
if (img is None):
    sys.exit("Não conseguimos abrir a imagem.")
p1 = [0,0]
p2 = [0,0]
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

print('Pontos 01:')
print("x >> ", p1[0], ' y >> ', p1[1])
print('\nPontos 02:')
print("x >> ", p2[0], ' y >> ', p2[1])

cv2.imshow('Imagem Normal', img)
cv2.waitKey(0)

print('Deixando negativo a região entre os dois pontos dados')

img[p1[0]:p2[0],p1[1]:p2[1]] = negativa_img(img[p1[0]:p2[0],p1[1]:p2[1]]) 

cv2.imshow('Imagem Negativa', img)
cv2.waitKey(0)
cv2.destroyAllWindows()