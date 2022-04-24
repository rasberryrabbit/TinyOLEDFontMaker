#include <avr/pgmspace.h>

const uint8_t ssd1306xled_RobotoLight [] PROGMEM = { 
// Roboto Light, size: 27
// Width=14, Height=24
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//32  
0x00,0x00,0x00,0x00,0x00,0xC0,0xC0,0xC0,0xC0,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x3F,0x3F,0x3F,0x3F,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x06,0x06,0x06,0x06,0x00,0x00,0x00,0x00,0x00,
//33 !
0x00,0x00,0x00,0xE0,0xE0,0xE0,0x00,0x00,0xE0,0xE0,0xE0,0x00,0x00,0x00,
0x00,0x00,0x00,0x01,0x01,0x01,0x00,0x00,0x01,0x01,0x01,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//34 "
0x00,0x00,0x00,0x00,0x00,0x80,0x40,0x00,0x00,0x00,0xC0,0x00,0x00,0x00,
0x00,0x40,0x42,0x42,0x7E,0x4F,0x42,0x42,0xC2,0xFA,0x43,0x42,0x02,0x00,
0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x00,0x00,
//35 #
0x00,0x00,0x00,0xC0,0x40,0x40,0x70,0x70,0x40,0x40,0x80,0x80,0x00,0x00,
0x00,0x80,0x87,0x0C,0x08,0x08,0x18,0x10,0x10,0x10,0x61,0xE3,0xC3,0x00,
0x00,0x00,0x01,0x02,0x02,0x04,0x0C,0x0C,0x04,0x06,0x03,0x03,0x01,0x00,
//36 $
0x00,0x80,0x40,0x40,0x40,0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x03,0x04,0x08,0x08,0xC7,0x20,0x18,0xE6,0x21,0x20,0x20,0xC0,0x00,
0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x03,0x04,0x04,0x02,0x01,0x00,
//37 %
0x00,0x00,0x00,0x80,0x40,0x40,0x40,0x40,0xC0,0x80,0x00,0x00,0x00,0x00,
0x00,0xC0,0xE0,0x17,0x18,0x18,0x34,0x24,0xC3,0x83,0x00,0xC0,0x60,0x00,
0x00,0x01,0x03,0x02,0x04,0x04,0x04,0x04,0x02,0x02,0x01,0x06,0x04,0x00,
//38 &
0x00,0x00,0x00,0x00,0x00,0xE0,0xE0,0xE0,0xE0,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x01,0x01,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//39 '
0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x80,0xC0,0x40,0x20,0x20,0x20,0x10,
0x00,0x00,0x00,0x20,0xFC,0xFF,0x03,0x03,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x03,0x07,0x0E,0x0E,0x18,0x10,0x20,0x20,0x20,0x40,
//40 (
0x00,0x10,0x10,0x20,0x60,0xC0,0x80,0x80,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x8F,0xFE,0xF8,0x00,0x00,0x00,
0x40,0x40,0x40,0x20,0x30,0x18,0x0C,0x0C,0x07,0x03,0x00,0x00,0x00,0x00,
//41 )
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xC0,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x01,0x00,0x12,0x1A,0x0A,0x06,0x07,0x0E,0x1A,0x12,0x12,0x01,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//42 *
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x10,0x10,0x10,0x10,0x10,0xFF,0xFF,0x10,0x10,0x10,0x10,0x10,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,
//43 +
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x18,0x18,0x0E,0x0E,0x06,0x06,0x00,0x00,0x00,0x00,
//44 ,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//45 -
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x06,0x06,0x06,0x00,0x00,0x00,0x00,0x00,0x00,
//46 .
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0xC0,0x40,0x00,
0x00,0x00,0x00,0x00,0x80,0xE0,0x30,0x18,0x0E,0x03,0x01,0x00,0x00,0x00,
0x00,0x0C,0x0E,0x03,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//47 /
0x00,0x00,0x00,0x80,0x40,0x40,0x40,0x40,0x40,0xC0,0x80,0x00,0x00,0x00,
0x00,0x7C,0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF,0x7C,0x00,
0x00,0x00,0x01,0x03,0x02,0x04,0x04,0x04,0x04,0x02,0x03,0x01,0x00,0x00,
//48 0
0x00,0x00,0x80,0xC0,0xC0,0x40,0x40,0xC0,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x00,0x00,0x00,
//49 1
0x00,0x00,0x80,0xC0,0x40,0x40,0x40,0x40,0x40,0x40,0x80,0x00,0x00,0x00,
0x00,0x03,0x03,0x00,0x00,0x80,0x40,0x60,0x30,0x18,0x0F,0x07,0x00,0x00,
0x00,0x04,0x06,0x05,0x05,0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x04,0x00,
//50 2
0x00,0x00,0x80,0xC0,0x40,0x40,0x40,0x40,0x40,0x40,0x80,0x80,0x00,0x00,
0x00,0x81,0x81,0x00,0x00,0x10,0x10,0x10,0x18,0x18,0x27,0xE7,0xC0,0x00,
0x00,0x01,0x03,0x02,0x02,0x04,0x04,0x04,0x04,0x02,0x03,0x01,0x00,0x00,
//51 3
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xC0,0xC0,0x00,0x00,0x00,0x00,
0x00,0xC0,0xE0,0x90,0x98,0x8C,0x82,0x81,0x80,0xFF,0x80,0x80,0x80,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x00,
//52 4
0x00,0x00,0x00,0xC0,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x00,0x00,
0x00,0x00,0x90,0x0F,0x08,0x00,0x04,0x04,0x04,0x0C,0x18,0xF0,0xE0,0x00,
0x00,0x00,0x01,0x03,0x02,0x06,0x04,0x04,0x04,0x06,0x03,0x01,0x00,0x00,
//53 5
0x00,0x00,0x00,0x80,0x80,0x40,0x40,0x40,0x40,0x40,0x40,0x00,0x00,0x00,
0x00,0x00,0xFF,0x09,0x08,0x08,0x04,0x04,0x04,0x0C,0x18,0xF8,0xF0,0x00,
0x00,0x00,0x00,0x03,0x02,0x02,0x04,0x04,0x04,0x06,0x03,0x01,0x01,0x00,
//54 6
0x00,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0xC0,0xC0,0x40,0x00,
0x00,0x00,0x00,0x00,0x00,0x80,0xF0,0x38,0x06,0x03,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x07,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//55 7
0x00,0x00,0x80,0xC0,0x40,0x40,0x40,0x40,0x40,0x40,0x80,0x80,0x00,0x00,
0x00,0xC2,0xE7,0x08,0x18,0x10,0x10,0x10,0x10,0x18,0x2F,0xE7,0xC2,0x00,
0x00,0x01,0x03,0x02,0x06,0x04,0x04,0x04,0x04,0x02,0x03,0x03,0x01,0x00,
//56 8
0x00,0x00,0x80,0xC0,0x40,0x40,0x40,0x40,0x40,0xC0,0x80,0x00,0x00,0x00,
0x00,0x1F,0x1F,0x20,0x60,0x40,0x40,0x40,0x20,0x20,0xFF,0xFF,0x7C,0x00,
0x00,0x00,0x00,0x04,0x04,0x04,0x04,0x04,0x02,0x02,0x01,0x01,0x00,0x00,
//57 9
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x06,0x06,0x06,0x06,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x06,0x06,0x06,0x06,0x00,0x00,0x00,0x00,0x00,
//58 :
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x06,0x06,0x06,0x06,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x00,0x18,0x18,0x0E,0x0E,0x06,0x06,0x00,0x00,0x00,0x00,0x00,
//59 ;
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x20,0x60,0x60,0x50,0x90,0x90,0x88,0x88,0x08,0x0C,0x04,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x01,0x01,0x00,0x00,
//60 <
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x00,0x48,0x48,0x48,0x48,0x48,0x48,0x48,0x48,0x48,0x48,0x00,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//61 =
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x04,0x04,0x0C,0x08,0x88,0x88,0x90,0x50,0x50,0x60,0x60,0x20,0x00,
0x00,0x03,0x01,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
//62 >
0x00,0x00,0x80,0x40,0x40,0x40,0x40,0x40,0x40,0x40,0xC0,0x80,0x00,0x00,
0x00,0x01,0x01,0x00,0x00,0x00,0x60,0x60,0x30,0x10,0x0C,0x07,0x03,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x06,0x06,0x00,0x00,0x00,0x00,0x00,0x00,
//63 ?
0x00,0x00,0x00,0x00,0x80,0x80,0x40,0x40,0x40,0x80,0x80,0x00,0x00,0x00,
0x00,0xF8,0x06,0x01,0xE0,0x18,0x04,0x04,0xF8,0x00,0x00,0x03,0xFC,0x00,
0x00,0x07,0x18,0x20,0x21,0x46,0x44,0x42,0x23,0x04,0x04,0x02,0x01,0x00
//64 @
};

const DCfont TinyOLED4kRobotoLight = {
  (uint8_t *)ssd1306xled_RobotoLight,
  14, // character width in pixels
  3, // character height in pages (8 pixels)
  32,64 // ASCII extents
};

// for backwards compatibility
#define ROBOTOLIGHT (&TinyOLED4kRobotoLight)