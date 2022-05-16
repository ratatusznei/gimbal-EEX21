#ifndef SERVOS_HPP
#define SERVOS_HPP
#include <Servo.h>
namespace servos {

Servo s1;
Servo s2;

void begin() {
	s1.attach(8);
	s2.attach(9);
}

void write(int a1, int a2) {
	s1.write(a1);
	s2.write(a2);
}

}
#endif // SERVOS_HPP

