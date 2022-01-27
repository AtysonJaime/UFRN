import numpy as np
import sys
import cv2
import random

# Variaveis globais
top_slider = 100;

# Realiza o filtro de Canny na img desejada
def filtroCanny(img):
    global top_slider, imgCanny
    imgCanny = cv2.Canny(img,top_slider, 3*top_slider)
    return imgCanny


# Cria uma imagem em Pontilhimos
def pontilhismo(img):
    height, width = img.shape
    
    # Pega o valor do raio aleatório
    radius = random.randint(1, 5)
    
    # Cria uma copia da img
    imgCopy = img.copy() 
    
    # Interação para criar os circulos aletoriamente
    for i in range(0,height,radius):
        for j in range(0,width,radius):
            number = random.randint(0, 1)
            if number == 1:
                # Pega a cor do pixel no ponto da matriz
                gray = int(img[i][j])
                color = (gray,gray,gray)
                # Cria um circulo com o raio encontrado aleatoriamente
                cv2.circle(imgCopy, (j,i), radius, color, radius)
                # Pega um novo valor para o raio
                radius = random.randint(1, 5)
    
    return imgCopy
            
            
img = cv2.imread("../img/dft.png", cv2.IMREAD_GRAYSCALE)
if (img is None):
    sys.exit("Não conseguimos abrir a imagem.")

height, width = img.shape

cv2.imshow("Original", img)

# Canny sendo feito aqui!
# cv2.imshow("canny", img)
# trackbarName = "Threshold inferior"
# cv2.createTrackbar(trackbarName,"canny",top_slider,top_slider_max, setTh)
imgCanny = filtroCanny(img)
cv2.imshow("Canny", imgCanny)
# -----

# Pontilhismo sendo feito aqui!
imgPonti = pontilhismo(img)
cv2.imshow("pontilhismo", imgPonti)
# ----

# Usando Canny com Pontilhismo
heightPonti, widthPonti = imgPonti.shape
radius = 4 # Os circulos das bordas terão raio 4, assim ficara em evidência comparado aos outros.

imgCannyPoint = imgPonti.copy()

# Verifica se na img de canny, o pixel é 255. Caso seja, cria um circulo de raio 6 no msm pixel da img canny com point
for i in range(heightPonti):
    for j in range(widthPonti):
        if (imgCanny[i][j] == 255):
            gray = int(img[i][j])
            color = (gray, gray, gray)
            cv2.circle(imgCannyPoint, (j, i), radius, color, radius)

cv2.imshow("cannypoint", imgCannyPoint)


cv2.waitKey(0)
cv2.destroyAllWindows()