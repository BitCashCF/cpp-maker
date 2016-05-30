#pragma once

extern "C" {
  #include "nrf_gpio.h"
}

class DigitalOut {
public:
  DigitalOut(uint8_t pin)
  : pin(pin) {
    nrf_gpio_cfg_output(pin);
  }

  void invert() {
    uint32_t gpio_state = NRF_GPIO->OUT;
    NRF_GPIO->OUTSET = ((1 << pin) & ~gpio_state);
    NRF_GPIO->OUTCLR = ((1 << pin) & gpio_state);
  }

private:
  uint8_t pin;
};
