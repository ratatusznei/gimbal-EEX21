SRC = $(wildcard *.cpp) $(wildcard *.hpp) $(wildcard *.ino)

compile: $(SRC)
	arduino-cli compile

upload: compile
	arduino-cli upload -vp /dev/ttyUSB0 

serial:
	picocom -b 115200 /dev/ttyUSB0
