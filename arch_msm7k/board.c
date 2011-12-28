#include <boot/boot.h>
#include <boot/board.h>

/* low-level init and partition table setup */
void board_init(void)
{
}
void board_reboot(void)
{
}
void board_getvar(const char *name, char *value)
{
}
void board_hang(void)
{
}

/* keypad init */
void keypad_init(void)
{
}

/* return a linux kernel commandline */
const char *board_cmdline(void)
{
	return (char *)0;
}
unsigned board_machtype(void)
{
	return 444;
}
