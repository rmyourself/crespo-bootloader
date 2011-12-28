libmsm7k_objs = clock.o \
				hsusb.o \
				mddi_console.o \
				nand.o uart.o \
				gpio.o mddi.o \
				vic.o shared.o \
				panel.o \
				board.o

all: start.o libmsm7k.a

libmsm7k.a: $(libmsm7k_objs)
	$(AR) crv $@ $^

clean:
	rm -f *.o *.a

.PHONY: all clean
