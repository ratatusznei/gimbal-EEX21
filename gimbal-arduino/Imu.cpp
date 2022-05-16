#include "Imu.hpp"

void Imu::begin() {
	mpu.upsideDownMounting = true;
	mpu.begin(0, 0);
	mpu.calcOffsets(true, true);
	// mpu.setFilterGyroCoef(0.98);
}

void Imu::print() {
	if (Serial) {
		Serial.print("Imu: ");
		Serial.print(get_correction_x());
		Serial.print(", ");
		Serial.println(get_correction_y());
	}
}
