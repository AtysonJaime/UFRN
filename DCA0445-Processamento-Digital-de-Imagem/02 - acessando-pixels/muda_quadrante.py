## Altera o quadrante das imagens, primeiro quadrante muda com o quarto e o terceiro muda com o segundo.

import cv2
import sys
import numpy

img = cv2.imread("../img/biel.png", cv2.IMREAD_GRAYSCALE)
if (img is None):
    sys.exit("Não conseguimos abrir a imagem.")
# Apresenta Imagem Original
cv2.namedWindow('Imagem Normal', cv2.WINDOW_AUTOSIZE)
cv2.imshow('Imagem Normal', img)

altura, largura =img.shape

# Pega os quadrantes da img original
primeiroQuadrante = img[0:altura//2,0:largura//2]
segundoQuadrante = img[0:altura//2,largura//2:largura]
terceiroQuadrante = img[altura//2:altura,0:largura//2]
quartoQuadrante = img[altura//2:altura,largura//2:largura]

# Cria uma nova imagem com os quadrantes da imagem original trocadas.
imgTrocada = numpy.zeros((altura, largura), numpy.uint8)   
imgTrocada[0:altura//2,0:largura//2] = quartoQuadrante
imgTrocada[0:altura//2,largura//2:largura] = terceiroQuadrante
imgTrocada[altura//2:altura,0:largura//2] = segundoQuadrante
imgTrocada[altura//2:altura,largura//2:largura] = primeiroQuadrante

# Apresenta Imagem Quadrantes Trocados
cv2.namedWindow('Imagem Quadrantes Trocados', cv2.WINDOW_AUTOSIZE)
cv2.imshow('Imagem Quadrantes Trocados', imgTrocada)
cv2.waitKey(0)

cv2.destroyAllWindows()