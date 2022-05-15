#ifndef JOYSTICK_HPP
#define JOYSTICK_HPP
namespace joystick {

const int VRx = A0;
const int VRy = A1;
const int SW = 2;

void setup() {
	pinMode(VRx, INPUT);
	pinMode(VRy, INPUT);
	pinMode(SW, INPUT_PULLUP); 
}

float readJoystick (int pos, float& out) {
	// int posicaoX = map(analogRead(VRx), 0, 1023, -200, 200);
	// int posicaoY = map(analogRead(VRy), 0, 1023, -200, 200);

	// readJoystick(posicaoX, offset[0]);
	// readJoystick(posicaoY, offset[1]);

	// if(digitalRead(SW) == LOW) {
	// 	offset[0] = 0;
	// 	offset[1] = 0;
	// 	offset[2] = 0;
	// }

	if (pos > 20) {
		out += .1;
		if (out > 60) {
			out = 60;
		}
	}
	if (pos < -60) {
		out -= .1;
		if (out < -60) {
			out = -60;
		}
	}
}

}
#endif // JOYSTICK_HPP
