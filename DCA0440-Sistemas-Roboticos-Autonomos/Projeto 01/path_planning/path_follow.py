from typing import Callable

import numpy

from path_planning import path_by_polynomials
from utils import Position


class PathFollow:
    __delta_x: Callable[[float], float]
    __delta_y: Callable[[float], float]
    __velocity_function: Callable[[float], float]
    __x_lambda: Callable[[float], float]
    __y_lambda: Callable[[float], float]
    __theta: Callable[[float], float]
    __length_path: float
    __last_time: float
    __last_lambda: float

    def __init__(self, initial_pos: Position, desired_pos: Position, initial_time_in_seconds: float, max_time: float):
        x_coefficients, y_coefficients = path_by_polynomials.find_coefficients(initial_pos, desired_pos)

        self.__x_lambda, self.__y_lambda, self.__theta = path_by_polynomials.create_path_functions(x_coefficients,
                                                                                                   y_coefficients)

        def delta_x(lambda_value: float) -> float:
            return x_coefficients[1] + 2 * x_coefficients[2] * lambda_value + 3 * x_coefficients[3] * lambda_value ** 2

        def delta_y(lambda_value: float) -> float:
            return y_coefficients[1] + 2 * y_coefficients[2] * lambda_value + 3 * y_coefficients[3] * lambda_value ** 2

        self.__delta_x = delta_x
        self.__delta_y = delta_y

        self.__length_path = path_by_polynomials.calculate_path_length(x_coefficients, y_coefficients)

        self.__velocity_function = self.__create_velocity_function(self.__length_path, max_time)

        self.__last_time = initial_time_in_seconds
        self.__last_lambda = 0.0

    @staticmethod
    def __create_velocity_function(length_path, max_time_in_seconds: float) -> Callable[[float], float]:
        max_velocity = 2 * length_path / max_time_in_seconds

        def velocity(time_in_seconds: float) -> float:
            return max_velocity * (1 - numpy.cos(2 * numpy.pi * time_in_seconds / max_time_in_seconds)) / 2

        return velocity

    def step(self, time_in_seconds: float) -> Position:
        v_t = self.__velocity_function

        def p_lambda(lambda_value: float, t: float) -> float:
            dl = numpy.sqrt(self.__delta_x(lambda_value) ** 2 + self.__delta_y(lambda_value) ** 2)
            dt = time_in_seconds - self.__last_time
            return v_t(t) * dt / dl

        lambda_t = self.__last_lambda + p_lambda(self.__last_lambda, time_in_seconds)
        self.__last_lambda = lambda_t
        self.__last_time = time_in_seconds

        return Position(self.__x_lambda(lambda_t), self.__y_lambda(lambda_t), self.__theta(lambda_t))
