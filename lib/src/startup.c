#include "misc.h"

// Gets called by startup.s
void SystemInit() {
    // Move vector table to start of RAM (0x20000000)
    SCB->VTOR = 0x20000000;
}