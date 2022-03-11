################################################################################
# Setup variables

# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a 
# package install, and verilator is in your path. Otheriwise find the binary
# relative to $VERILATOR_ROOT (such as the inside of the git sources)
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif

# Generate C++ in executable form
VERILATOR_FLAGS += -cc
# Generate makefile dependencies
VERILATOR_FLAGS += -MMD
# Optimize
# VERILATOR_FLAGS += -Os -x-assign 0
# Warn about lint issues
VERILATOR_FLAGS += -Wall
# Make waveforms
VERILATOR_FLAGS += --trace
# Check SystemVerilog assertions
VERILATOR_FLAGS += --coverage
# Run Verilator in debug mode
# VERILATOR_FLAGS += --debug
# Add this trace to get a backtrace in gdb
# VERILATOR_FLAGS += --gdbbt
# RTL source dir
RTL += ../hdl

# Input files for Verilator
FILES += input.vc $(RTL)/snn.v tb.cpp

################################################################################
default: run

run:
	@echo
	@echo "-- Verilator tracking example"

	@echo
	@echo "-- VERILATE -----------------"
	$(Verilator) $(VERILATOR_FLAGS) $(FILES)

	@echo
	@echo "-- BUILD --------------------"
# To compile, we can either
# 1. Pass --build to Verilator by editing VERILATOR_FLAGS above.
# 2. Or, run the make rules Verilator does:
	$(MAKE) -j -C obj_dir -f Vsnn.mk
# 3. Or, call a submakefile where we can override the rules ourselves:
# 	$(MAKE) -j -C obj_dir -f ./Makefile_obj

	@echo
	@echo "-- RUN ----------------------"
	@rm -rf logs
	@mkdir -p logs
	obj_dir/Vtop +trace

	@echo
	@echo " -- COVERAGE ----------------"
	@rm -rf logs/annotated
	$(VERILATOR_COVERAGE) --annotate logs/annotated logs/coverage.dt'

	@echo
	@echo "-- Done ---------------------"

################################################################################
# Other targets

show-config:
	$(VERILATOR) -v

maintainer-copy::
clean mostlyclean distclean maintainer_clean::
	-rm -rf obj_dir logs *.logs *.dmp *.vpd coverage.dat core