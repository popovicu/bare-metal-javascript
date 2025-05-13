PREFIX = /opt/riscv-newlib/bin/riscv64-unknown-elf-
CC = $(PREFIX)gcc
AS = $(PREFIX)as
LD = $(PREFIX)ld

CFLAGS = -march=rv64imac_zicsr -mabi=lp64 -mcmodel=medany -specs=nosys.specs -O2 -g -Wall
LDFLAGS = -T link.ld -nostartfiles 

SRCS = js.c elk.c uart.c
ASRCS = startup.S
OBJS = $(SRCS:.c=.o) $(ASRCS:.S=.o)

firmware.elf: $(OBJS) link.ld
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDFLAGS_EXTRA) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) firmware.elf qemu_debug.log

run: firmware.elf
	qemu-system-riscv64 -machine virt -m 256 -nographic -bios firmware.elf

debug: firmware.elf
	qemu-system-riscv64 -machine virt -m 256 -nographic -bios firmware.elf -d in_asm,cpu_reset -D qemu_debug.log