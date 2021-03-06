#ifndef SERVODRIVER_HPP
#define SERVODRIVER_HPP

#include <Servo.h>
#include <Arduino.h>

class ServoController {
	Servo sx;
	Servo sy;
	int x{90};
	int y{90};
	int tx{90};
	int ty{90};

	int xf[5]{0};
	int xs{0};
	int xi{0};

	int yf[5]{0};
	int ys{0};
	int yi{0};

	unsigned long last_update{0};
	static constexpr unsigned long update_period = 20; // ms
public:
	void begin();
	inline void set_target(int x, int y) { tx = x; ty = y; }
	void update();

	void print() {
		Serial.print("Servos: ");
		Serial.print(x);
		Serial.print(", ");
		Serial.print(y);
		Serial.print(", ");
		Serial.print(tx);
		Serial.print(", ");
		Serial.print(ty);
		Serial.println();
	}
};

#endif // SERVODRIVER_HPP
