#ifndef SERVODRIVER_HPP
#define SERVODRIVER_HPP

#include <Servo.h>

class ServoController {
	Servo sx;
	Servo sy;
	int x{90};
	int y{90};
	int tx{90};
	int ty{90};
	unsigned long last_update{0};
	static constexpr unsigned long update_period = 20; // ms
public:
	ServoController();
	inline void set_target(int x, int y) { tx = x; ty = y; }
	void update();
};

#endif // SERVODRIVER_HPP
