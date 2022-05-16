#include "ServoController.hpp"
#include <Arduino.h>

void ServoController::begin() {
	sx.attach(8);
	sy.attach(9);
	sx.write(x);
	sy.write(y);
}

void ServoController::update() {
	unsigned long now = millis();
	if (now - last_update >= update_period) {
		last_update = now;

		x += (tx - x) / 2;
		y += (ty - y) / 2;
		sx.write(x);
		sy.write(y);
	}
}
