import numpy as np
import sys
import cv2
import matplotlib.pyplot as plt

cap = cv2.VideoCapture(0)
if not cap.isOpened():
    sys.exit("Não conseguimos abrir a câmera.")

# Seto a largura e altura da janela de video
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640);
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480);

# Configura plotagem do Gráfico de Histograma
fig, ax = plt.subplots()
ax.set_title('Histogram (grayscale)')
ax.set_xlabel('Itensidade do Cinza')
ax.set_ylabel('Frequência do Cinza')
lineGray, = ax.plot(np.arange(256),np.zeros((256,1)), c='r', lw=3)
lineEqu, = ax.plot(np.arange(256),np.zeros((256,1)), c='b', lw=3)
ax.set_xlim(0, 255)
ax.set_ylim(0, 5000)
plt.ion()
plt.show()
plt.legend(["Histograma Frame", "Histograma Frame Equalizado"])

while True:
    # Capture frame por frame
    ret, frame = cap.read()

    # Se o frame estiver sido lido, ret retorna true
    if not ret:
        print("Não conseguir ler o frame do video. Webcan ainda funcioando ?")
        break

    # Trasforma imagem recebida em escala de cinza
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    # Calcula o histograma do frame
    histGray = cv2.calcHist([gray],[0],None,[256], [0, 256])
    lineGray.set_ydata(histGray)
    
    # Equaliza frame
    equ = cv2.equalizeHist(gray)

    # Calcula o histograma do frame Equalizado
    histEqu = cv2.calcHist([equ],[0],None,[256], [0, 256]) 
    lineEqu.set_ydata(histEqu)
    
    # Apresenta os dois frames, antes e o depois.
    res = np.hstack((gray, equ))
    cv2.imshow('Equalização', res)

    # Caso aperte q, aplicação é encerrada 
    if cv2.waitKey(1) == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()