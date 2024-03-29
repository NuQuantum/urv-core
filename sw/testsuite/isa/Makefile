#=======================================================================
# Makefile for riscv-tests/isa
#-----------------------------------------------------------------------

isa_src_dir := .

#include $(isa_src_dir)/rv64ui/Makefrag
#include $(isa_src_dir)/rv64uf/Makefrag
#include $(isa_src_dir)/rv64uv/Makefrag
#include $(isa_src_dir)/rv64si/Makefrag
#include $(isa_src_dir)/rv64sv/Makefrag
#include $(isa_src_dir)/rv64mi/Makefrag
include $(isa_src_dir)/rv32ui/Makefrag
#include $(isa_src_dir)/rv32si/Makefrag
include $(isa_src_dir)/rv32mi/Makefrag
include $(isa_src_dir)/urv/Makefrag

default: all

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

RISCV_PREFIX=riscv32-elf-
RISCV_GCC = $(RISCV_PREFIX)gcc
ENTROPY = -DENTROPY=$(shell echo $$$$)
RISCV_GCC_OPTS = $(ENTROPY) -mcmodel=medany -nostartfiles -fvisibility=hidden -march=rv32im -mabi=ilp32 -DSIM -I../../common
RISCV_OBJDUMP = $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data
RISCV_SIM = spike --extension=hwacha

COMMON_SRCS = ../../common/crt0.S ../../common/irq.S emulate.o ../../common/test-common.c

vpath %.S $(isa_src_dir)

emulate.o: ../../common/emulate.c
	$(RISCV_GCC) -c $(RISCV_GCC_OPTS) -mabi=ilp32 -march=rv32i -o $@ $<

#------------------------------------------------------------
# Build assembly tests

%.ram: %
	$(RISCV_PREFIX)objcopy -O binary $< tmp.bin
	../../genraminit tmp.bin 4096 > $@

%.dump: %
	$(RISCV_OBJDUMP) $< > $@

%.out: %
	$(RISCV_SIM) $< 2> $@

%.out32: %
	$(RISCV_SIM) --isa=RV32 $< 2> $@

define compile_template

$$($(1)_p_tests): $(1)-p-%: $(1)/%.S emulate.o
	$$(RISCV_GCC) $(2) $$(RISCV_GCC_OPTS) -I$(isa_src_dir)/../env/p -I$(isa_src_dir)/macros/scalar $(COMMON_SRCS) -T ../../common/ram2.ld  $$< -o $$@
$(1)_tests += $$($(1)_p_tests)

$(1)_tests_dump = $$(addsuffix .dump, $$($(1)_tests))
$(1)_tests_ram = $$(addsuffix .ram, $$($(1)_tests))

$(1): $$($(1)_tests_dump) $$($(1)_tests_ram)

.PHONY: $(1)

tests += $$($(1)_tests)

endef

$(eval $(call compile_template,rv32ui,))
$(eval $(call compile_template,urv,))

tests_dump = $(addsuffix .dump, $(tests))
tests_ram = $(addsuffix .ram, $(tests))
tests_out = $(addsuffix .out, $(spike_tests))
tests32_out = $(addsuffix .out32, $(spike32_tests))

run: $(tests_out) $(tests32_out)
	echo; perl -ne 'print "  [$$1] $$ARGV \t$$2\n" if /\*{3}(.{8})\*{3}(.*)/' \
	       $(tests_out) $(tests32_out); echo;

junk += $(tests) $(tests_dump) $(tests_ram) $(tests_out) $(tests32_out)

#------------------------------------------------------------
# Default

all: $(tests_dump) $(tests_ram)

#------------------------------------------------------------
# Clean up

clean:
	rm -rf $(junk)
