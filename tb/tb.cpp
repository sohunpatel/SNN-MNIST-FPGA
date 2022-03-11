#include <verilated.h>

#include <memory>

#include "Vsnn.h"

double sc_time_stamp() { return 0; }

int main(int argc, char** argv, char** env) {
  if (false && argc && argv && env) {
  }

  Verilated::mkdir("logs");

  const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
  contextp->debug(0);
  contextp->randReset(2);
  contextp->traceEverOn(true);
  contextp->commandArgs(argc, argv);

  const std::unique_ptr<Vsnn> snn{new Vsnn{contextp.get(), "TOP"}};
  snn->clk = 0;
}