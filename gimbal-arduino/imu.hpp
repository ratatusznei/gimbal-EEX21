#ifndef IMU_HPP
#define IMU_HPP
#include "Wire.h"
#include <MPU6050_light.h>
namespace imu {

MPU6050 mpu(Wire);

struct Vec3 {
	float x;
	float y;
	float z;
} angle;

void begin() {
	mpu.upsideDownMounting = true;
	mpu.begin();
	// mpu.setFilterGyroCoef(0.98);
	mpu.calcOffsets(true, true);
}

void update() {
	mpu.update();
	angle.x = mpu.getAngleX();
	angle.y = mpu.getAngleY();
	angle.z = mpu.getAngleZ();
}

void print() {
	Serial.print(angle.x);
	Serial.print(", ");
	Serial.print(angle.y);
	Serial.print(", ");
	Serial.println(angle.z);
}

}
#endif // IMU_HPP
