#include "omv_boardconfig.h"

#define MICROPY_HW_BOARD_NAME       "FONTAE V1 F7"
#define MICROPY_HW_MCU_NAME         "STM32F767"
#define MICROPY_PY_SYS_PLATFORM     "FONTAE V1 F7"

#define MICROPY_HW_HAS_SWITCH       (1)
#define MICROPY_HW_HAS_SDCARD       (1)
#define MICROPY_HW_HAS_MMA7660      (0)
#define MICROPY_HW_HAS_LIS3DSH      (0)
#define MICROPY_HW_HAS_LCD          (0)
#define MICROPY_HW_ENABLE_RNG       (1)
#define MICROPY_HW_ENABLE_RTC       (1)
#define MICROPY_HW_ENABLE_TIMER     (1)
#define MICROPY_HW_ENABLE_DAC       (1)
#define MICROPY_HW_ENABLE_SPI1      (1)
#define MICROPY_HW_ENABLE_SPI2      (1)
#define MICROPY_HW_ENABLE_SPI3      (1)
#define MICROPY_HW_ENABLE_SPI4      (1)
#define MICROPY_HW_ENABLE_USB       (1)
#define MICROPY_FATFS_EXFAT         (1)

#if (OMV_USE_QSPI_FLASH_VFS)
#define MICROPY_HW_ENABLE_INTERNAL_FLASH_STORAGE (0)

#define MICROPY_FATFS_MAX_SS            (OMV_FATFS_MAX_SS)
#define MICROPY_HW_USB_MSC_MEDIA_PACKET (OMV_USB_MSC_MEDIA_PACKET)
#endif /* OMV_USE_QSPI_FLASH_VFS */

#define MICROPY_HW_CLK_PLLM (8)
#define MICROPY_HW_CLK_PLLN (400)
#define MICROPY_HW_CLK_PLLQ (9)
#define MICROPY_HW_CLK_PLLR (2)
#define MICROPY_HW_CLK_PLLP (RCC_PLLP_DIV2)

// UART1 config
#define MICROPY_HW_UART1_TX  (pin_B14)
#define MICROPY_HW_UART1_RX  (pin_B15)

// UART2 config
#define MICROPY_HW_UART2_TX  (pin_D5)
#define MICROPY_HW_UART2_RX  (pin_D6)

// UART3 config
#define MICROPY_HW_UART3_TX  (pin_B10)
#define MICROPY_HW_UART3_RX  (pin_B11)

// UART4 config
#define MICROPY_HW_UART4_TX  (pin_H13)
#define MICROPY_HW_UART4_RX  (pin_H14)

// UART5 config
#define MICROPY_HW_UART5_TX  (pin_B13)
#define MICROPY_HW_UART5_RX  (pin_B12)

// I2C2 buses
#define MICROPY_HW_I2C2_SCL (pin_H4)
#define MICROPY_HW_I2C2_SDA (pin_H5)

// I2C3 buses
#define MICROPY_HW_I2C3_SCL (pin_H7)
#define MICROPY_HW_I2C3_SDA (pin_H8)

// I2C4 buses
#define MICROPY_HW_I2C4_SCL (pin_D12)
#define MICROPY_HW_I2C4_SDA (pin_D13)

// SPI1 buses
#define MICROPY_HW_SPI1_NSS  (pin_A15)
#define MICROPY_HW_SPI1_SCK  (pin_A5)
#define MICROPY_HW_SPI1_MISO (pin_G9)
#define MICROPY_HW_SPI1_MOSI (pin_D7)

// SPI2 buses
#define MICROPY_HW_SPI2_SCK  (pin_I1)
#define MICROPY_HW_SPI2_MISO (pin_I2)
#define MICROPY_HW_SPI2_MOSI (pin_I3)

// SPI3 buses
#define MICROPY_HW_SPI3_SCK  (pin_B3)
#define MICROPY_HW_SPI3_MISO (pin_B4)
#define MICROPY_HW_SPI3_MOSI (pin_B5)

// SPI4 buses
#define MICROPY_HW_SPI4_SCK  (pin_E2)
#define MICROPY_HW_SPI4_MISO (pin_E5)
#define MICROPY_HW_SPI4_MOSI (pin_E6)

// SPI6 buses
#define MICROPY_HW_SPI6_NAME "BLE_SPI"
#define MICROPY_HW_SPI6_NSS  (pin_I9)
#define MICROPY_HW_SPI6_SCK  (pin_G13)
#define MICROPY_HW_SPI6_MISO (pin_G12)
#define MICROPY_HW_SPI6_MOSI (pin_G14)

// CAN busses
#define MICROPY_HW_CAN2_NAME "CAN2" // CAN2 on RX,TX = P3,P2 = PB12,PB13
#define MICROPY_HW_CAN2_TX          (pin_B13)
#define MICROPY_HW_CAN2_RX          (pin_B12)

// SD card detect switch
#define MICROPY_HW_SDCARD_DETECT_PIN        (pin_H15)
#define MICROPY_HW_SDCARD_DETECT_PULL       (GPIO_PULLUP)
#define MICROPY_HW_SDCARD_DETECT_PRESENT    (GPIO_PIN_RESET)

// USB config
#define MICROPY_HW_USB_FS                   (1)
#define MICROPY_HW_USB_VBUS_DETECT_PIN      (pin_A9)
//#define MICROPY_HW_USB_OTG_ID_PIN         (pin_A10)

// USRSW is pulled high. Pressing the button makes the input go low.
#define MICROPY_HW_USRSW_PIN        (pin_C13)
#define MICROPY_HW_USRSW_PULL       (GPIO_NOPULL)
#define MICROPY_HW_USRSW_EXTI_MODE  (GPIO_MODE_IT_FALLING)
#define MICROPY_HW_USRSW_PRESSED    (0)

// LEDs
#define MICROPY_HW_LED1             (pin_C5) // red
#define MICROPY_HW_LED2             (pin_A7) // green
#define MICROPY_HW_LED3             (pin_C4) // blue
#define MICROPY_HW_LED4             (pin_I0) // orange
#define MICROPY_HW_LED_OTYPE        (GPIO_MODE_OUTPUT_PP)
#define MICROPY_HW_LED_ON(pin)      (mp_hal_pin_low(pin))
#define MICROPY_HW_LED_OFF(pin)     (mp_hal_pin_high(pin))
