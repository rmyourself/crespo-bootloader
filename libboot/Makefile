libboot_objs = flash.o \
				poll.o \
				tags_partition.o \
				tags_revision.o \
				tags_serialno.o \
				tags_cmdline.o \
				gpio_keypad.o \
				init.o \
				tags.o

all: libboot.a

libboot.a: $(libboot_objs)
	$(AR) crv $@ $^

clean:
	rm -f *.o *.a

.PHONY: all clean
