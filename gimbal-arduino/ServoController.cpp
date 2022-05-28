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

		constexpr int alpha = 0.99;
		x = x*alpha + tx*(1.-alpha);
		y = y*alpha + ty*(1.-alpha);

		xs += x;
		xs -= xf[xi];
		xf[xi] = x;
		xi = (xi + 1) % 5;

		ys += y;
		ys -= yf[yi];
		yf[yi] = y;
		yi = (yi + 1) % 5;

		sx.write(xs / 5);
		sy.write(ys / 5);
	}
}
