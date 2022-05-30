#ifndef IMU_HPP
#define IMU_HPP
#include "Wire.h"
#include <MPU6050_light.h>

class Imu {
	MPU6050 mpu;
public:
	Imu(): mpu(Wire) {}
	void begin();
	void print();
	inline void update() { mpu.update(); }

	inline float get_correction_y() { return 90 + mpu.getAngleY(); }
	inline float get_correction_x() { return 90 + mpu.getAngleX(); }
};
#endif // IMU_HPP
