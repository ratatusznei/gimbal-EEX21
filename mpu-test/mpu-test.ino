#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps_V6_12.h"

MPU6050 mpu;

// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint8_t fifoBuffer[64]; // FIFO storage buffer

Quaternion q;           // [w, x, y, z]         quaternion container


void setup() {
  Serial.begin(115200);
  while (!Serial);

  Serial.println(F("Initializing I2C devices..."));
  mpu.initialize();

  Serial.println(F("Testing device connections..."));
  Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));

  delay(2000);
  Serial.println(F("Initializing DMP..."));
  devStatus = mpu.dmpInitialize();

  mpu.setXGyroOffset(51);
  mpu.setYGyroOffset(8);
  mpu.setZGyroOffset(21);
  mpu.setXAccelOffset(1150);
  mpu.setYAccelOffset(-50);
  mpu.setZAccelOffset(1060);

  if (devStatus == 0) {
    mpu.CalibrateAccel();
    mpu.CalibrateGyro();
    mpu.PrintActiveOffsets();

    Serial.println(F("Enabling DMP..."));
    mpu.setDMPEnabled(true);
    Serial.println(F("DMP ready!"));
    dmpReady = true;

    packetSize = mpu.dmpGetFIFOPacketSize();
	mpu.setRate(10); // 1kHz / (n + 5)
  } else {
    // ERROR!
    // 1 = initial memory load failed
    // 2 = DMP configuration updates failed
    // (if it's going to break, usually the code will be 1)
    Serial.print(F("DMP Initialization failed (code "));
    Serial.print(devStatus);
    Serial.println(F(")"));
  }
}

void loop() {
  if (!dmpReady) return;

  if (mpu.dmpGetCurrentFIFOPacket(fifoBuffer)) {

    mpu.dmpGetQuaternion(&q, fifoBuffer);
    Serial.print("{\"w\":");
    Serial.print(q.w);
    Serial.print(",\"x\":");
    Serial.print(q.x);
    Serial.print(",\"y\":");
    Serial.print(q.y);
    Serial.print(",\"z\":");
    Serial.print(q.z);
    Serial.println("}");
  }
}
