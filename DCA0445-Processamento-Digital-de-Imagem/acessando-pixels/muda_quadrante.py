## Altera o quadrante das imagens, primeiro quadrante muda com o quarto e o terceiro muda com o segundo.

import cv2
import sys
import numpy

cv2.namedWindow('Imagem Normal', cv2.WINDOW_AUTOSIZE)
cv2.namedWindow('Imagem Quadrantes Trocados', cv2.WINDOW_AUTOSIZE)

img = cv2.imread("biel.png", cv2.IMREAD_GRAYSCALE)
if (img is None):
    sys.exit("Não conseguimos abrir a imagem.")
cv2.imshow('Imagem Normal', img)
cv2.waitKey(0)

altura, largura =img.shape

primeiroQuadrante = img[0:altura//2,0:largura//2]
segundoQuadrante = img[0:altura//2,largura//2:largura]
terceiroQuadrante = img[altura//2:altura,0:largura//2]
quartoQuadrante = img[altura//2:altura,largura//2:largura]

imgTrocada = numpy.zeros((altura, largura), numpy.uint8)  
cv2.imshow('Imagem Quadrantes Trocados', imgTrocada)
cv2.waitKey(0)
    
imgTrocada[0:altura//2,0:largura//2] = quartoQuadrante
cv2.imshow('Imagem Quadrantes Trocados', imgTrocada)
cv2.waitKey(0)
imgTrocada[0:altura//2,largura//2:largura] = terceiroQuadrante
cv2.imshow('Imagem Quadrantes Trocados', imgTrocada)
cv2.waitKey(0)
imgTrocada[altura//2:altura,0:largura//2] = segundoQuadrante
cv2.imshow('Imagem Quadrantes Trocados', imgTrocada)
cv2.waitKey(0)
imgTrocada[altura//2:altura,largura//2:largura] = primeiroQuadrante
cv2.imshow('Imagem Quadrantes Trocados', imgTrocada)
cv2.waitKey(0)

cv2.destroyAllWindows()