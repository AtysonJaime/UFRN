import numpy as np
import sys
import cv2
import math

# Adiciona variavies globais para realização dos calculos da formula do filtro homomorfico
yh,yl,c,d0 = 1,1,1,1
dft, dft_M, dft_N = 0,0,0
yv,cv,dv = 0,0,0

# Função Filtro Homomorfico.
def filtroHomomorfico():
    global yh, yl, c, d0, dft, dft_M, dft_N
    du = np.zeros(dft.shape, dtype=np.float32)
    print(dft.shape, dft_M, dft_N, c, d0)
    for u in range(dft_M):
        for v in range(dft_N):
            du[u,v] = math.sqrt((u-dft_M/2.0)*(u-dft_M/2.0)+(v-dft_N/2.0)*(v-dft_N/2.0))
    
    du2 = cv2.multiply(du,du) / (d0*d0)
    re = np.exp(-c*du2)
    H = (yh - yl)*(1 - re) + yl
    
    # Realizando a DFT inversa
    filtrando = cv2.mulSpectrums(dft,H,0)
    filtrando = np.fft.ifftshift(filtrando)
    filtrando = cv2.idft(filtrando)
    filtrando = cv2.magnitude(filtrando[:,:,0], filtrando[:,:,1])
    
    #normaliza
    cv2.normalize(filtrando,filtrando,0, 1, cv2.NORM_MINMAX)
    filtrando = np.exp(filtrando)
    cv2.normalize(filtrando, filtrando,0, 1, cv2.NORM_MINMAX) 
    
    # Apresenta resultado
    cv2.imshow("homomorfico", filtrando)   
    
# Criação das funções auxiliares para filtragem.
def setyl(yv):
    global yl
    yl = yv/10.0
    if yl > yh:
        yl = yh - 1
    filtroHomomorfico()

def setyh(yv):
    global yh
    yh = yv/10.0
    if 1 > yh:
        yh = 1
    if yl > yh:
        yh = yl + 1
    filtroHomomorfico()

def setc(cv):
    global c
    if cv == 0:
        print('Entrei aqui quando C = 0')
        cv = 1
    c = cv/1000.0
    filtroHomomorfico()

def setd0(dv):
    global d0
    d0 = dv/10.0
    if d0 == 0:
        print('Entrei aqui quando d0 = 0')
        d0 = 1
    filtroHomomorfico()      

# Pega a imagem desejada para a transformada de furrier
img = cv2.imread("../img/dft.png", cv2.IMREAD_GRAYSCALE)
if (img is None):
    sys.exit("Não conseguimos abrir a imagem.")
    
# Mostra a imagem original
cv2.imshow("original", img)

# Transforma a imagem em ponto flutuante
img = np.float32(img)

# Pega altura e largura da imagem
height, width = img.shape

# Pega a altura e a largura ideal para a DFT
dft_M = cv2.getOptimalDFTSize(height)
dft_N = cv2.getOptimalDFTSize(width)

# Realiza o padding da imagem adicionando zero as bordas e realiza o log da img.
padded = cv2.copyMakeBorder(img, 0, dft_M-height,0,dft_N-width, cv2.BORDER_CONSTANT, 0) + 1
padded = np.log(padded)

# Aplica a DFT na imagem é um shift nos quadrantes
dft = cv2.dft(padded, flags=cv2.DFT_COMPLEX_OUTPUT)
dft = np.fft.fftshift(dft)
img_back = 20*np.log(cv2.magnitude(dft[:,:,0],dft[:,:,1]))
esp_freq = np.uint8(img_back)
cv2.imshow("espectro da frequencia", esp_freq)
cv2.imshow("homomorfico", img)

trackbarName = "YL "
cv2.createTrackbar(trackbarName,"homomorfico",yv,100,setyl)
trackbarName = "YH "
cv2.createTrackbar(trackbarName,"homomorfico",yv,100,setyh)
trackbarName = "C "
cv2.createTrackbar(trackbarName,"homomorfico",cv,100,setc)
trackbarName = "D0 "
cv2.createTrackbar(trackbarName,"homomorfico",dv,dft_M,setd0)

cv2.waitKey(0)
cv2.destroyAllWindows()