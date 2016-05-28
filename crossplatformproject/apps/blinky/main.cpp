#include <stdbool.h>
#include <stdint.h>

extern "C" {
  #include "nrf_delay.h"
  #include "nrf_gpio.h"
}

#define LEDS_CONFIGURE(leds_mask) do { uint32_t pin;                  \
                                  for (pin = 0; pin < 32; pin++) \
                                      if ( (leds_mask) & (1 << pin) )   \
                                          nrf_gpio_cfg_output(pin); } while (0)
#define LEDS_INVERT(leds_mask) do { uint32_t gpio_state = NRF_GPIO->OUT;      \
                              NRF_GPIO->OUTSET = ((leds_mask) & ~gpio_state); \
                              NRF_GPIO->OUTCLR = ((leds_mask) & gpio_state); } while (0)

const uint8_t led = 1;

int main(void)
{
    // Configure LED-pins as outputs.
    LEDS_CONFIGURE(1 << led);

    // Toggle LEDs.
    while (true)
    {
        LEDS_INVERT(1 << led);
        nrf_delay_ms(500);
    }
}
