#include <stdbool.h>
#include <stdint.h>

#include "DigitalOut.hpp"

extern "C" {
  #include "nrf_delay.h"
}

DigitalOut led(12);

int main(void)
{
    while (true)
    {
      led.invert();
      nrf_delay_ms(1500);
    }
}
