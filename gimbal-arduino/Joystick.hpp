#ifndef JOYSTICK_HPP
#define JOYSTICK_HPP
#include <Arduino.h> 

class Joystick {
	static constexpr int VRx = A0;
	static constexpr int VRy = A1;
	static constexpr int SW = 2;
	static constexpr unsigned long update_period = 20; // ms

	int offsetX{};
	int offsetY{};
	unsigned long last_update{0};
public:
	void begin() {
		pinMode(VRx, INPUT);
		pinMode(VRy, INPUT);
		pinMode(SW, INPUT_PULLUP); 
	}

	void print() {
		if (Serial) {
			Serial.print("Joystick: ");
			Serial.print(offsetX);
			Serial.print(", ");
			Serial.println(offsetY);
		}
	}

	void atualiza_offset(int pos, int& out) {
		if (pos > 50) {
			out += 1;
			if (out > 60) {
				out = 60;
			}
		}
		if (pos < -50) {
			out -= 1;
			if (out < -60) {
				out = -60;
			}
		}
	}

	int get_offset_x() { return offsetX; }
	int get_offset_y() { return offsetY; }

	void update() {
		if (digitalRead(SW) == LOW) {
			offsetY = offsetX = 0;
			return;
		}
		unsigned long now = millis();
		if (now - last_update >= update_period) {
			last_update = now;
			int posicaoX = map(analogRead(VRx), 0, 1023, -100, 100);
			int posicaoY = map(analogRead(VRy), 0, 1023, -100, 100);
			atualiza_offset(posicaoX, offsetX);
			atualiza_offset(posicaoY, offsetY);
		}
	}
};

#endif // JOYSTICK_HPP
