#include <Adafruit_MPU6050.h>
// https://adafruit.github.io/Adafruit_MPU6050/html/index.html

Adafruit_MPU6050 mpu;
struct Vec3 {
  float x;
  float y;
  float z;
};

Vec3 acc;
Vec3 gyro;

void setup_mpu() {
  if (mpu.begin()) {
    mpu.setAccelerometerRange(MPU6050_RANGE_2_G);
    mpu.setGyroRange(MPU6050_RANGE_250_DEG);
    mpu.setCycleRate(MPU6050_CYCLE_1_25_HZ);
  }
  else {
    Serial.println("Erro ao iniciar mpu");
  }
}

void read_mpu() {
  sensors_event_t a, g; 
  mpu.getAccelerometerSensor()->getEvent(&a);
  mpu.getGyroSensor()->getEvent(&g);
  acc.x = a.acceleration.x;
  acc.y = a.acceleration.y;
  acc.z = a.acceleration.z;
  gyro.x = g.gyro.x;
  gyro.y = g.gyro.y;
  gyro.z = g.gyro.z;
}

void setup() {
  Serial.begin(9600);
  setup_mpu();
  Serial.println("Inicializado");
}

void loop() {
  read_mpu();
  float g0 = sqrt(acc.x*acc.x + acc.y*acc.y + acc.z*acc.z);
  float omega = sqrt(gyro.x*gyro.x + gyro.y*gyro.y + gyro.z*gyro.z);

  Serial.print("G: ");
  Serial.print(g0);
  Serial.print(", Gyro: ");
  Serial.println(omega);
  delay(100);
}
