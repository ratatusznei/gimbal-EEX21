#include "ServoController.hpp"
#include <Arduino.h>

ServoController::ServoController() {
	sx.attach(8);
	sx.attach(9);
}

void ServoController::update() {
	unsigned long now = millis();
	if (last_update - now >= update_period) {
		last_update = now;

		x += (tx - x) / 2;
		y += (ty - y) / 2;
		sx.write(x);
		sy.write(y);
	}
}
