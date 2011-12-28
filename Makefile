#
#
#	ns-boot 
#
#
#
#


include $(CURDIR)/.config


CROSS_COMPILE = /opt/arm-2011.03/bin/arm-none-eabi-

export AS		= $(CROSS_COMPILE)as
export LD		= $(CROSS_COMPILE)ld
export CC		= $(CROSS_COMPILE)gcc
export CPP		= $(CROSS_COMPILE)$(CC) -E
export AR		= $(CROSS_COMPILE)ar
export NM		= $(CROSS_COMPILE)nm
export STRIP	= $(CROSS_COMPILE)strip
export OBJCOPY	= $(CROSS_COMPILE)objcopy
export OBJDUMP	= $(CROSS_COMPILE)objdump
export RANLIB	= $(CROSS_COMPILE)RANLIB


DBGFLAGS= -g # -DDEBUG
OPTFLAGS= -Os #-fomit-frame-pointer
LDSCRIPT = $(CURDIR)/arch_$(CONFIG_ARCH)/$(CONFIG_ARCH).lds

gccincdir := $(shell $(CC) -print-file-name=include)
export CPPFLAGS	= -D__KERNEL__ -DTEXT_BASE=$(TEXT_BASE) \
					-I$(CURDIR)/include 			\
					-fno-builtin -ffreestanding -nostdinc -isystem $(gccincdir) \
					-pipe -march=armv7-a -fno-strict-aliasing -fno-common -ffixed-r8
export CFLAGS 	= $(CPPFLAGS) -Wall -Wstrict-prototypes
export AFLAGS	= $(CPPFLAGS) -D__ASSEMBLY__
export LDFLAGS	= -Bstatic -T $(LDSCRIPT) -Ttext $(TEXT_BASE) -L $(shell dirname `$(CC) $(CFLAGS) -print-libgcc-file-name`) -lgcc



#########################################
#            GO GO GO ! ! !             #
#########################################

SUBDIRS	= arch_$(CONFIG_ARCH) libboot libc usbloader
OBJS	= arch_$(CONFIG_ARCH)/start.o usbloader/main.o usbloader/usbloader.o
LIBS	= arch_$(CONFIG_ARCH)/lib$(CONFIG_ARCH).a libboot/libboot.a libc/libc.a

ALL = ns-boot.bin System.map
all: $(ALL)

ns-boot.bin: ns-boot.elf
	$(OBJCOPY) --gap-fill=0xff -O binary $< $@
	@echo "bootloader is ready:" $@

System.map:	ns-boot.elf
	@$(NM) $< | \
	grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | \
	sort > System.map

ns-boot.elf: $(OBJS) $(LIBS)
	$(LD) $(LDFLAGS) $(OBJS) $(LIBS) -Map ns-boot.map -o $@

$(OBJS): $(SUBDIRS)
$(LIBS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

clean:
	$(foreach d, $(SUBDIRS), $(MAKE) -C $d $@;)
	-rm -f *.o ns-boot.elf ns-boot.map $(ALL)

.PHONY: $(SUBDIRS) all clean
