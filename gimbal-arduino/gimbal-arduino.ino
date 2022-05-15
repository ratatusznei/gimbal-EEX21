#include "mpu.hpp"
#include "servos.hpp"
#include "joystick.hpp"

/*
Sequencia de funcionamento (loop):
  1.Coleta dos dados do sensor MPU6050
  2.Leitura do joystick analogico
  3.Operações sobre os dados lidos + variação analogicos
    -Partindo sempre da posição de calibração, a cada loop serão calculadas as inclinações + variação desejada,
    de modo que a cada loop teremos novos valores para o posicionamentos dos servos.
    -A variação lida do joystick em qualquer loop deve permanecer após o fim do mesmo.
  4.Saída para os servos
    -Com limitantes de velocidade (sem guinadas -> movimentação suave dentro dos limites de velocidade)
*/

// imagens do acelerometro:
//https://bdm.unb.br/bitstream/10483/23639/1/2018_EduardoSousaSalesRodrigues_tcc.pdf

void setup() {
	Serial.begin(115200);
	while (!Serial);

	mpu::setup();
	joystick::setup();
	servos::setup();
}

void loop() {
	mpu::read();
	mpu::print_accel();
	servos::write(0, 90 - mpu::angle.y);
}
