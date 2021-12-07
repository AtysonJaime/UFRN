# Import para mexer com o openCV no python
import cv2
import sys
import numpy

def createImage(altura,largura,ehColorida):
    """[Cria uma imagem de altura e largura definidas pelo usuário]

    Args:
        altura ([number]): [Altura da Imagem]
        largura ([number]): [Largura da Imagem]
        ehColorida ([bool]): [é colorida ?]

    Returns:
        [list]: [Retorna a imagem criada]
    """
    if ehColorida:
        return np.zeros((altura,largura,3), np.uint8)
    else:
        return np.zeros((altura,largura), np.uint8)

cv2.namedWindow('Imagem Exemplo', cv2.WINDOW_AUTOSIZE) ## Usado para criar uma tela para mostrar as imagens


## Trabalhando com imagem em escala de cinza
img = cv2.imread("bolhas.png", cv2.IMREAD_GRAYSCALE) ### Abre uma imagem em escala de cinza
if img is None:
    sys.exit("Não conseguimos abrir a imagem.")  ### Valida se a imagem foi aberta pelo sistema.

cv2.imshow('Imagem Exemplo', img) ### Função para visualizar imagem.
cv2.waitKey(0) ### Espera acionamento de alguma tecla para continuar.

### Criando uma imagem padrão cinza, para tal usa-se a biblioteca numpy
imgCriada = numpy.zeros((altura,largura),numpy.uint8) 
# -> Os paramentro passados são os tamanhos da matriz imagem(altura, largura).
# -> numpy.uint8 serve para identificar que a matriz segue o padrão 8bit(0 ~ 255) valores

### Para saber o tamanho da sua imagem padrão preto e branco:
altura, largura =img.shape # -> Retorna dois valores quando img é cinza.

### Para acessar um espaço:
img[0,0], img[altura,largura] # -> Retornara o valor da posição, ou receberá uma valor entre 0 e 255
imgCriada[0,0], imgCriada[altura,largura]
### Para acessar varios espaço:
img[:,:], img[0:altura/2,0:largura] # -> Retornará os valores de cada posição, ou essas posições receberam algum valor entre 0 e 255
imgCriada[:,:], imgCriada[0:altura/2,0:largura]

### Caso por exemplo:
img[0:altura/2,0:largura] = imgQuadrante1
### e imgQuadrante for uma matriz também, cada posição da img dentro desse intervalo passado,
### receberá seu corelacionada em imgQuadrante1, ou seja, img[0,0] recebe imgQuadrante1[0,0] e assim sucessivamente
### até finalizar o intervalo passado.


#--------------------------------------------------------------
## Trabalhando com imagens Coloridas
imgColorida = cv2.imread("bolhas.png", cv2.IMREAD_COLOR) ### Abre uma imagem em escala colorida (B,G,R)
if imgColorida is None:
    sys.exit("Não conseguimos abrir a imagem.")  ### Valida se a imagem foi aberta pelo sistema.

cv2.imshow('Imagem Exemplo', imgColorida) ### Função para visualizar imagem.
cv2.waitKey(0) ### Espera acionamento de alguma tecla para continuar.

# Quando a imagem é colorida, a função shape retorna 3 valores apenas.
altura, largura, n_canais =img.shape # -> Altura, Largura e a quantidade de canais(nesse caso 3 por ser RGB)

## IMPORTANTE - As cores sempre seguem a ordem [B,G,R], diferentemente do convencional RGB que nós falamos. 

### Criar um array de um Cor, existe dois modos:
# 1 - usando a biblioteca numpy
colorGreen = numpy.array([0,255,0]) #Verde - G
colorBlue = numpy.array([255,0,0]) #Azul - B
colorRed = numpy.array([0,0,255]) #Vermelho - R
# 2 - criando array em python
colorGreen = [0,255,0] #Verde - G
colorBlue = [255,0,0] #Azul - B
colorRed = [0,0,255] #Vermelho - R


### Criando uma imagem colorida, para tal usa-se a biblioteca numpy
colorida = numpy.zeros((altura,largura,3), numpy.uint8) 
# -> Altura, Largura, Dimensão - por ser colorida RGB a dimensão é 3 
# -> numpy.uint8 serve para identificar que a matriz segue o padrão 8bit(0 ~ 255) valores

### Para acessar um espaço:
imgColorida[0,0], imgColorida[altura,largura] 
# -> Retornara o array com os 3 valores(B,G,R) da posição, ou receberá um array com os 3 valores(B,G,R) entre 0 e 255
colorida[0,0], colorida[altura,largura]

### Para acessar varios espaço:
imgColorida[:,:], imgColorida[0:altura/2,0:largura] 
# -> Retornará os valores dos arrays com os 3 valores(B,G,R) de cada posição, ou essas posições receberam algum array com os 3 valores(B,G,R) entre 0 e 255
colorida[:,:], colorida[0:altura/2,0:largura]

### Caso por exemplo:
imgColorida[0:altura/2,0:largura] = imgQuadrante1
### e imgQuadrante for uma matriz colorida também, cada posição da imgColorida dentro desse intervalo passado,
### receberá seu corelacionada em imgQuadrante1, ou seja, imgColorida[0,0] recebe o array(B,G,R) de imgQuadrante1[0,0] e assim sucessivamente
### até finalizar o intervalo passado.
#--------------------------------------------------------------
#cv2.destroyAllWindows mata todas as janelas abertas;
cv2.destroyAllWindows()



#---------------------------------------------------------------
## Trabalhando com Video
cap = cv2.VideoCapture(0) # Inicializa a webcam
if not cap.isOpened():
    sys.exit("Não conseguimos abrir a câmera.")

# Seto a largura e altura da janela de video
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640);
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480);

# Capture frame por frame
while True:
    ret, frame = cap.read()

    # Se o frame estiver sido lido, ret retorna true
    if not ret:
        print("Não conseguir ler o frame do video. Webcan ainda funcioando ?")
        break

    # Trasforma imagem recebida em escala de cinza
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    histGray = cv2.calcHist([gray],[0],None,[256], [0, 256])

    # Apresenta os dois frames, antes e o depois.
    res = numpy.hstack((gray, equ)) # Mostra duas imagens juntas
    cv2.imshow('Equalização', res) # Apresebta freme
    # Caso aperte q, aplicação é encerrada 
    if cv2.waitKey(1) == ord('q'):
        break

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()


