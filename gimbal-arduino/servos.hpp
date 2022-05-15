#ifndef SERVOS_HPP
#define SERVOS_HPP
#include <Servo.h>
namespace servos {

Servo s1;
Servo s2;

void setup() {
	s1.attach(8);
	s2.attach(9);
}

void write() {
	/* s1.write(120*(-euler[0] + 1.) + offset[0]); */
	/* s2.write(120*(euler[1] + 1.) + offset[1]); */
}

}
#endif // SERVOS_HPP

