import cv2
import numpy as np
import matplotlib.pyplot as plt
 
# To read image from disk, we use
# cv2.imread function, in below method,
# img = cv2.imread("../img/biel.png", cv2.IMREAD_COLOR)
 
# # Creating GUI window to display an image on screen
# # first Parameter is windows title (should be in string format)
# # Second Parameter is image array
# cv2.imshow("Cute Kitens", img)

fig, ax = plt.subplots()
ax.set_title('Histogram (grayscale)')
ax.set_xlabel('Itensidade do Cinza')
ax.set_ylabel('Frequência do Cinza')
lineGray, = ax.plot(np.arange(10),np.zeros((10,1)), c='r', lw=3)
lineEqu, = ax.plot(np.arange(10),np.zeros((10,1)), c='b', lw=3)
ax.set_xlim(0, 10)
ax.set_ylim(0, 25)
plt.ion()
plt.show()
plt.legend(["Histograma Frame", "Histograma Frame Equalizado"])

img = np.array([[0,5,7,7,5,8,7,8],
                [7,2,6,2,6,5,6,8],
                [6,9,7,7,0,7,2,7],
                [6,6,1,7,6,7,7,5],
                [9,6,0,7,8,2,6,7],
                [2,8,8,2,7,6,7,8],
                [7,3,2,6,1,7,5,8],
                [9,9,5,6,7,7,7,7]],dtype=np.uint8)

histGray = cv2.calcHist([img],[0],None,[10], [0, 10])
lineGray.set_ydata(histGray)

imgHist = np.array([histGray],dtype=np.uint8)
# Equaliza frame
equ = cv2.equalizeHist(imgHist)

# Calcula o histograma do frame Equalizado
histEqu = cv2.calcHist([equ],[0],None,[10], [0, 10]) 
lineEqu.set_ydata(histEqu)
 
# To hold the window on screen, we use cv2.waitKey method
# Once it detected the close input, it will release the control
# To the next line
# First Parameter is for holding screen for specified milliseconds
# It should be positive integer. If 0 pass an parameter, then it will
# hold the screen until user close it.
cv2.imshow('Equalização', img)
cv2.imshow('equializado', equ)
cv2.waitKey(0)
 
# It is for removing/deleting created GUI window from screen
# and memory
cv2.destroyAllWindows()