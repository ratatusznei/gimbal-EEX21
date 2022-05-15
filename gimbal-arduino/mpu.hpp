#ifndef MPU_HPP
#define MPU_HPP
#include "Wire.h"
#include <MPU6050_light.h>
namespace mpu{

MPU6050 mpu(Wire);

struct Vec3 {
	float x;
	float y;
	float z;
} angle;

void setup() {
	mpu.upsideDownMounting = true;
	Serial.print("MPU: ");
	Serial.println(mpu.begin());
	mpu.calcOffsets(true, true);
}

void read() {
	mpu.update();
	angle.x = mpu.getAngleX();
	angle.y = mpu.getAngleY();
	angle.z = mpu.getAngleZ();
}

void print_accel() {
	Serial.print(angle.x);
	Serial.print(", ");
	Serial.print(angle.y);
	Serial.print(", ");
	Serial.println(angle.z);
}

}
#endif // MPU_HPP
