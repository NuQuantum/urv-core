# and don't touch the rest unless you know what you're doing.
CROSS_COMPILE ?= /opt/gcc-riscv/bin/riscv64-unknown-elf-

XCC =		$(CROSS_COMPILE)gcc
LD =		$(CROSS_COMPILE)ld
OBJDUMP =	$(CROSS_COMPILE)objdump
OBJCOPY =	$(CROSS_COMPILE)objcopy
SIZE =		$(CROSS_COMPILE)size

OUTPUT=test_irq

CFLAGS = -mabi=ilp32 -march=rv32im
OBJS = ../common/crt0.o ../common/irq.o $(OUTPUT).o
LDS = ../common/ram2.ld


$(OUTPUT): $(LDS) $(OBJS) ../genraminit
	${XCC} $(CFLAGS) -o $(OUTPUT).elf -nostartfiles $(OBJS) -T $(LDS)
	${OBJCOPY} -O binary $(OUTPUT).elf $(OUTPUT).bin
	${OBJDUMP} -D $(OUTPUT).elf > disasm.S
	$(SIZE) $(OUTPUT).elf
#	../genramvhd -p wrc_simulation_firmware $(OUTPUT).bin >  wrc_simulation_firmware_pkg.vhd
	../genraminit $(OUTPUT).bin 1000 > $(OUTPUT).ram

clean:
	rm -f $(OUTPUT).elf $(OUTPUT).bin $(OBJS)

%.o: %.S
	${XCC} -c $(CFLAGS) $< -o $@

%.o: %.c
	${XCC} -c $(CFLAGS) $< -o $@
