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
    