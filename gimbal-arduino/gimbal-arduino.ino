#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps612.h"
#include <Servo.h>

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


Servo s1;
Servo s2;

const int VRx = A0;
const int VRy = A1;
const int SW = 2;

MPU6050 mpu;
Quaternion q;
float euler[3]{ 0 };
float offset[3]{ 0 };

// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint8_t fifoBuffer[64]; // FIFO storage buffer

float readJoystick (int pos, float& out) {
	if (pos > 20) {
		out += .1;
		if (out > 60) {
			out = 60;
		}
	}
	if (pos < -60) {
		out -= .1;
		if (out < -60) {
			out = -60;
		}
	}
}

void setup() {
	Serial.begin(115200);
	while (!Serial);

	Serial.println(F("Initializing I2C devices..."));
	mpu.initialize();

	Serial.println(F("Testing device connections..."));
	Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));

	delay(2000);
	Serial.println(F("Initializing DMP..."));
	devStatus = mpu.dmpInitialize();

	mpu.setXGyroOffset(51);
	mpu.setYGyroOffset(8);
	mpu.setZGyroOffset(21);
	mpu.setXAccelOffset(1150);
	mpu.setYAccelOffset(-50);
	mpu.setZAccelOffset(1060);

	if (devStatus == 0) {
		mpu.CalibrateAccel();
		mpu.CalibrateGyro();
		mpu.PrintActiveOffsets();

		Serial.println(F("Enabling DMP..."));
		mpu.setDMPEnabled(true);
		Serial.println(F("DMP ready!"));
		dmpReady = true;

		packetSize = mpu.dmpGetFIFOPacketSize();
		mpu.setRate(10); // 1kHz / (n + 5)
	} else {
		// ERROR!
		// 1 = initial memory load failed
		// 2 = DMP configuration updates failed
		// (if it's going to break, usually the code will be 1)
		Serial.print(F("DMP Initialization failed (code "));
		Serial.print(devStatus);
		Serial.println(F(")"));
	}

	s1.attach(8);
	s2.attach(9);

	pinMode(VRx, INPUT);
	pinMode(VRy, INPUT);
	pinMode(SW, INPUT_PULLUP); 
}

void loop() {
	if (!dmpReady) return;

	if (mpu.dmpGetCurrentFIFOPacket(fifoBuffer)) {
		mpu.dmpGetQuaternion(&q, fifoBuffer);
		/* Serial.print("{\"w\":");
		   Serial.print(q.w);
		   Serial.print(",\"x\":");
		   Serial.print(q.x);
		   Serial.print(",\"y\":");
		   Serial.print(q.y);
		   Serial.print(",\"z\":");
		   Serial.print(q.z);
		   Serial.println("}"); */

		mpu.dmpGetEuler(euler, &q);
		s1.write(120*(-euler[0] + 1.) + offset[0]);
		s2.write(120*(euler[1] + 1.) + offset[1]);
	}

	// if(digitalRead(SW) == LOW) {
	// 	offset[0] = 0;
	// 	offset[1] = 0;
	// 	offset[2] = 0;
	// }

	// int posicaoX = map(analogRead(VRx), 0, 1023, -200, 200);
	// int posicaoY = map(analogRead(VRy), 0, 1023, -200, 200);

	// readJoystick(posicaoX, offset[0]);
	// readJoystick(posicaoY, offset[1]);
}
