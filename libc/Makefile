libc_objs = dprintf.o \
			xprintf.o \
			cprintf.o \
			sprintf.o \
			malloc.o \
			memcmp.o \
			memcpy.o \
			memset.o \
			strcpy.o \
			strlen.o \
			strcmp.o \
			strstr.o \
			crypto.o \
			rsa.o \
			sha.o \
			_udivsi3.o \
			div0.o

all: libc.a

libc.a: $(libc_objs)
	$(AR) crv $@ $^

clean:
	rm -f *.o *.a

.PHONY: all clean
