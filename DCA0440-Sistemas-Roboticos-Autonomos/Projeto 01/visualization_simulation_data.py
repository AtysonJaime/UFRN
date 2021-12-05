from matplotlib import pyplot as plt

import numpy as np


simulation_data = np.loadtxt('main_trajectory_follow.csv', delimiter=',', skiprows=1)


simulation_sample_header = ['linear_velocity_x',
                            'linear_velocity_y',
                            'angular_velocity_theta',
                            'current_pos_x',
                            'current_pos_y',
                            'current_pos_theta',
                            'desired_pos_x',
                            'desired_pos_y',
                            'desired_pos_theta',
                            'time_in_seconds'
                            ]

linear_velocity_x = simulation_data[:, 0]
linear_velocity_y = simulation_data[:, 1]
angular_velocity_theta = simulation_data[:, 2]

current_pos_x = simulation_data[:, 3]
current_pos_y = simulation_data[:, 4]
current_pos_theta = simulation_data[:, 5]

desired_pos_x = simulation_data[:, 6]
desired_pos_y = simulation_data[:, 7]
desired_pos_theta = simulation_data[:, 8]
time_in_seconds = simulation_data[:, 9]


# plt.figure('Posições do Robo(x) X Tempo(s)')
# plt.plot(time_in_seconds, current_pos_x)
# plt.plot(time_in_seconds, desired_pos_x)
# plt.legend(["Pos X", "Pos X Desejada"])
# plt.xlabel('Tempo(s)')
# plt.ylabel('Posições(X)')

# plt.figure('Posições do Robo(y) X Tempo(s)')
# plt.plot(time_in_seconds, current_pos_y)
# plt.plot(time_in_seconds, desired_pos_y)
# plt.legend(["Pos Y", "Pos Y Desejada"])
# plt.xlabel('Tempo(s)')
# plt.ylabel('Posições(Y)')


plt.figure('Posições do Robo(theta) X Tempo(s)')
plt.plot(time_in_seconds, current_pos_theta)
plt.plot(time_in_seconds, desired_pos_theta)
plt.legend(["Pos theta", "Pos theta Desejada"])
plt.xlabel('Tempo(s)')
plt.ylabel('Posição(theta)')


# plt.figure('Posições do Robo')
# plt.plot(current_pos_x, current_pos_y)
# plt.plot(desired_pos_x, desired_pos_y)
# plt.legend(["Posição(x) X Posição(y)", "Posição desejada(x) X Posição desejada(y)"])
# plt.xlabel('Posição X')
# plt.ylabel('Posição Y')


# plt.figure('Velocidade linear X Tempo(s)')
# plt.xlabel('Tempo(s)')
# plt.ylabel('Velocidade linear(X,Y)')
# plt.plot(time_in_seconds, linear_velocity_x)
# plt.plot(time_in_seconds, linear_velocity_y)
# plt.legend(["Velocidade Linear X", "Velocidade Linear Y"])


# plt.figure('Velocidade Angular X Tempo(s)')
# plt.xlabel('Tempo(s)')
# plt.ylabel('Velocidade Angular(theta)')
# plt.plot(time_in_seconds, angular_velocity_theta)


plt.show()