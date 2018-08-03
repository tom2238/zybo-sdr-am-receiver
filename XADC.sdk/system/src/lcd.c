/*
 * lcd.c
 *
 *  Created on: Mar 5, 2017
 *      Author: rd
 */
/*

#include "xparameters.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "xstatus.h"

// Masks to the pins on the GPIO port

#define LCD_DB4    0x01
#define LCD_DB5    0x02
#define LCD_DB6    0x04
#define LCD_DB7    0x08
#define LCD_RW     0x10
#define LCD_RS     0x20
#define LCD_E      0x40
#define LCD_TEST   0x80

// Global variables

XGpio GpioOutput;
XTmrCtr DelayTimer;

// Function prototypes

void delay_us(Xuint32 time);
void delay_ms(Xuint32 time);
void gpio_write(Xuint32 c);
Xuint32 gpio_read(void);
void lcd_clk(void);
void lcd_set_test(void);
void lcd_reset_test(void);
void lcd_set_rs(void);
void lcd_reset_rs(void);
void lcd_set_rw(void);
void lcd_reset_rw(void);
void lcd_write(Xuint32 c);
void lcd_clear(void);
void lcd_puts(const char * s);
void lcd_putch(Xuint32 c);
void lcd_goto(Xuint32 line,Xuint32 pos);
void lcd_init(void);

// Main function

int main (void)
{
  Xuint32 status;

  // Clear the screen
  xil_printf("%c[2J",27);
  xil_printf("16x2 LCD Driver by Virtex-5 Resource\r\n");
  xil_printf("http://www.fpgadeveloper.com\r\n");

  // Initialize the Timer
  status = XTmrCtr_Initialize(&DelayTimer,
                                XPAR_XPS_TIMER_0_DEVICE_ID);
  if (status != XST_SUCCESS){
    xil_printf("Timer failed to initialize\r\n");
    return XST_FAILURE;
  }
  XTmrCtr_SetOptions(&DelayTimer, 1, XTC_DOWN_COUNT_OPTION);

  // Initialize the GPIO driver for the LCD
  status = XGpio_Initialize(&GpioOutput,
                                 XPAR_XPS_GPIO_0_DEVICE_ID);
  if (status != XST_SUCCESS){
    xil_printf("GPIO failed to initialize\r\n");
    return XST_FAILURE;
  }
  // Set the direction for all signals to be outputs
  XGpio_SetDataDirection(&GpioOutput, 1, 0x00);

  // Initialize the LCD
  lcd_init();

  // Example write to the LCD
  lcd_puts("http://www.fpga");
  lcd_goto(1,2);
  lcd_puts("developer.com");

  while(1){
  }
}

// Delay function (microseconds)
void delay_us(Xuint32 time)
{
  usleep(time);
}

// Delay function (milliseconds)
void delay_ms(Xuint32 time)
{
  usleep(time*1000);
}

// Write to GPIO outputs
void gpio_write(Xuint32 c)
{
  // Write to the GP IOs
  XGpio_DiscreteWrite(&LCD16, 1, c & 0x0FF);
}

// Read the GPIO outputs
Xuint32 gpio_read()
{
  // Read from the GP IOs
  return(XGpio_DiscreteRead(&LCD16, 1));
}

// Clock the LCD (toggles E)
void lcd_clk()
{
  Xuint32 c;
  // Get existing outputs
  c = gpio_read();
  delay_us(1);
  // Assert clock signal
  gpio_write(c | LCD_E);
  delay_us(1);
  // Deassert the clock signal
  gpio_write(c & (~LCD_E));
  delay_us(1);
}

// Assert the RS signal
void lcd_set_rs()
{
  Xuint32 c;
  // Get existing outputs
  c = gpio_read();
  // Assert RS
  gpio_write(c | LCD_RS);
  delay_us(1);
}

// Deassert the RS signal
void lcd_reset_rs()
{
  Xuint32 c;
  // Get existing outputs
  c = gpio_read();
  // Assert RS
  gpio_write(c & (~LCD_RS));
  delay_us(1);
}

// Assert the RW signal
void lcd_set_rw()
{
  Xuint32 c;
  // Get existing outputs
  c = gpio_read();
  // Assert RS
  gpio_write(c | LCD_RW);
  delay_us(1);
}

// Deassert the RW signal
void lcd_reset_rw()
{
  Xuint32 c;
  // Get existing outputs
  c = gpio_read();
  // Assert RS
  gpio_write(c & (~LCD_RW));
  delay_us(1);
}

// Write a byte to LCD (4 bit mode)
void lcd_write(Xuint32 c)
{
  Xuint32 temp;
  // Get existing outputs
  temp = gpio_read();
  temp = temp & 0xF0;
  // Set the high nibble
  temp = temp | ((c >> 4) & 0x0F);
  gpio_write(temp);
  // Clock
  lcd_clk();
  // Delay for "Write data into internal RAM 43us"
  delay_us(100);
  // Set the low nibble
  temp = temp & 0xF0;
  temp = temp | (c & 0x0F);
  gpio_write(temp);
  // Clock
  lcd_clk();
  // Delay for "Write data into internal RAM 43us"
  delay_us(100);
}

// Clear LCD
void lcd_clear(void)
{
  lcd_reset_rs();
  // Clear LCD
  lcd_write(0x01);
  // Delay for "Clear display 1.53ms"
  delay_ms(2);
}

// Write a string to the LCD
void lcd_puts(const char * s)
{
  lcd_set_rs();
  while(*s)
    lcd_write(*s++);
}

// Write character to the LCD
void lcd_putch(Xuint32 c)
{
  lcd_set_rs();
  lcd_write(c);
}

// Change cursor position
// (line = 0 or 1, pos = 0 to 15)
void lcd_goto(Xuint32 line, Xuint32 pos)
{
  lcd_reset_rs();
  pos = pos & 0x3F;
  if(line == 0)
    lcd_write(0x80 | pos);
  else
    lcd_write(0xC0 | pos);
}

// Initialize the LCD
void lcd_init(void)
{
  Xuint32 temp;

  // Write mode (always)
  lcd_reset_rw();
  // Write control bytes
  lcd_reset_rs();

  // Delay 15ms
  delay_ms(15);

  // Initialize
  temp = gpio_read();
  temp = temp | LCD_DB5;
  gpio_write(temp);
  lcd_clk();
  lcd_clk();
  lcd_clk();

  // Delay 15ms
  delay_ms(15);

  // Function Set: 4 bit mode, 1/16 duty, 5x8 font, 2 lines
  lcd_write(0x28);
  // Display ON/OFF Control: ON
  lcd_write(0x0C);
  // Entry Mode Set: Increment (cursor moves forward)
  lcd_write(0x06);

  // Clear the display
  lcd_clear();
} */


// ARDUINO
/*
 *
 *
 *
 // commands
#define LCD_CLEARDISPLAY 0x01
#define LCD_RETURNHOME 0x02
#define LCD_ENTRYMODESET 0x04
#define LCD_DISPLAYCONTROL 0x08
#define LCD_CURSORSHIFT 0x10
#define LCD_FUNCTIONSET 0x20
#define LCD_SETCGRAMADDR 0x40
#define LCD_SETDDRAMADDR 0x80

// flags for display entry mode
#define LCD_ENTRYRIGHT 0x00
#define LCD_ENTRYLEFT 0x02
#define LCD_ENTRYSHIFTINCREMENT 0x01
#define LCD_ENTRYSHIFTDECREMENT 0x00

// flags for display on/off control
#define LCD_DISPLAYON 0x04
#define LCD_DISPLAYOFF 0x00
#define LCD_CURSORON 0x02
#define LCD_CURSOROFF 0x00
#define LCD_BLINKON 0x01
#define LCD_BLINKOFF 0x00

// flags for display/cursor shift
#define LCD_DISPLAYMOVE 0x08
#define LCD_CURSORMOVE 0x00
#define LCD_MOVERIGHT 0x04
#define LCD_MOVELEFT 0x00

// flags for function set
#define LCD_8BITMODE 0x10
#define LCD_4BITMODE 0x00
#define LCD_2LINE 0x08
#define LCD_1LINE 0x00
#define LCD_5x10DOTS 0x04
#define LCD_5x8DOTS 0x00

  uint8_t _rs_pin; // LOW: command.  HIGH: character.
  uint8_t _rw_pin; // LOW: write to LCD.  HIGH: read from LCD.
  uint8_t _enable_pin; // activated by a HIGH pulse.
  uint8_t _data_pins[8];

  uint8_t _displayfunction;
  uint8_t _displaycontrol;
  uint8_t _displaymode;

  uint8_t _initialized;

  uint8_t _numlines;
  uint8_t _row_offsets[4];
 */
 /*
 * void LiquidCrystal(uint8_t rs,  uint8_t enable,
			     uint8_t d0, uint8_t d1, uint8_t d2, uint8_t d3)
{
  LCinit(1, rs, 255, enable, d0, d1, d2, d3, 0, 0, 0, 0);
}

void LCinit(uint8_t fourbitmode, uint8_t rs, uint8_t rw, uint8_t enable,
			 uint8_t d0, uint8_t d1, uint8_t d2, uint8_t d3,
			 uint8_t d4, uint8_t d5, uint8_t d6, uint8_t d7)
{
  _rs_pin = rs;
  _rw_pin = rw;
  _enable_pin = enable;

  _data_pins[0] = d0;
  _data_pins[1] = d1;
  _data_pins[2] = d2;
  _data_pins[3] = d3;
  _data_pins[4] = d4;
  _data_pins[5] = d5;
  _data_pins[6] = d6;
  _data_pins[7] = d7;

  if (fourbitmode)
    _displayfunction = LCD_4BITMODE | LCD_1LINE | LCD_5x8DOTS;
  else
    _displayfunction = LCD_8BITMODE | LCD_1LINE | LCD_5x8DOTS;

  LCbegin(16, 1);
}

void LCbegin(uint8_t cols, uint8_t lines, uint8_t dotsize) {
  if (lines > 1) {
    _displayfunction |= LCD_2LINE;
  }
  _numlines = lines;

  LCsetRowOffsets(0x00, 0x40, 0x00 + cols, 0x40 + cols);

  // for some 1 line displays you can select a 10 pixel high font
  if ((dotsize != LCD_5x8DOTS) && (lines == 1)) {
    _displayfunction |= LCD_5x10DOTS;
  }
 /*
  /pinMode(_rs_pin, OUTPUT);
  // we can save 1 pin by not using RW. Indicate by passing 255 instead of pin#
  if (_rw_pin != 255) {
    pinMode(_rw_pin, OUTPUT);
  }
  pinMode(_enable_pin, OUTPUT);

  // Do these once, instead of every time a character is drawn for speed reasons.
  for (int i=0; i<((_displayfunction & LCD_8BITMODE) ? 8 : 4); ++i)
  {
    pinMode(_data_pins[i], OUTPUT);
   }

  // SEE PAGE 45/46 FOR INITIALIZATION SPECIFICATION!
  // according to datasheet, we need at least 40ms after power rises above 2.7V
  // before sending commands. Arduino can turn on way before 4.5V so we'll wait 50
  usleep(50000);
  // Now we pull both RS and R/W low to begin commands
  lcdOut &= ~(1 << 1); //RS LOW
    LCgpio();
  lcdOut &= ~(1 << 0); //EN LOW
    LCgpio();

  //if (_rw_pin != 255) {
   // digitalWrite(_rw_pin, LOW);
  //}

  //put the LCD into 4 bit or 8 bit mode
  if (! (_displayfunction & LCD_8BITMODE)) {
    // this is according to the hitachi HD44780 datasheet
    // figure 24, pg 46

    // we start in 8bit mode, try to set 4 bit mode
    LCwrite4bits(0x03);
    usleep(4500); // wait min 4.1ms

    // second try
    LCwrite4bits(0x03);
    usleep(4500); // wait min 4.1ms

    // third go!
    LCwrite4bits(0x03);
    usleep(150);

    // finally, set to 4-bit interface
    LCwrite4bits(0x02);
  } else {
    // this is according to the hitachi HD44780 datasheet
    // page 45 figure 23

    // Send function set command sequence
    LCcommand(LCD_FUNCTIONSET | _displayfunction);
    usleep(4500);  // wait more than 4.1ms

    // second try
    LCcommand(LCD_FUNCTIONSET | _displayfunction);
    usleep(150);

    // third go
    LCcommand(LCD_FUNCTIONSET | _displayfunction);
  }

  // finally, set # lines, font size, etc.
  LCcommand(LCD_FUNCTIONSET | _displayfunction);

  // turn the display on with no cursor or blinking default
  _displaycontrol = LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKOFF;
  LCdisplay();

  // clear it off
  LCclear();

  // Initialize to default text direction (for romance languages)
  _displaymode = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;
  // set the entry mode
  LCcommand(LCD_ENTRYMODESET | _displaymode);

}

void LCsetRowOffsets(int row0, int row1, int row2, int row3)
{
  _row_offsets[0] = row0;
  _row_offsets[1] = row1;
  _row_offsets[2] = row2;
  _row_offsets[3] = row3;
}

/********** high level commands, for the user! */
//void LCclear()
//{
//  LCcommand(LCD_CLEARDISPLAY);  // clear display, set cursor position to zero
//  usleep(2000);  // this command takes a long time!
//}
//
//void LChome()
//{
//  LCcommand(LCD_RETURNHOME);  // set cursor position to zero
//  usleep(2000);  // this command takes a long time!
//}
//
//void LCsetCursor(uint8_t col, uint8_t row)
//{
//  const size_t max_lines = sizeof(_row_offsets) / sizeof(*_row_offsets);
//  if ( row >= max_lines ) {
//    row = max_lines - 1;    // we count rows starting w/0
//  }
//  if ( row >= _numlines ) {
//    row = _numlines - 1;    // we count rows starting w/0
//  }
//
//  LCcommand(LCD_SETDDRAMADDR | (col + _row_offsets[row]));
//}
//
//// Turn the display on/off (quickly)
//void LCnoDisplay() {
//  _displaycontrol &= ~LCD_DISPLAYON;
//  LCcommand(LCD_DISPLAYCONTROL | _displaycontrol);
//}
//void LCdisplay() {
//  _displaycontrol |= LCD_DISPLAYON;
//  LCcommand(LCD_DISPLAYCONTROL | _displaycontrol);
//}
//
//// Turns the underline cursor on/off
//void LCnoCursor() {
//  _displaycontrol &= ~LCD_CURSORON;
//  LCcommand(LCD_DISPLAYCONTROL | _displaycontrol);
//}
//void LCcursor() {
//  _displaycontrol |= LCD_CURSORON;
//  LCcommand(LCD_DISPLAYCONTROL | _displaycontrol);
//}
//
//// Turn on and off the blinking cursor
//void LCnoBlink() {
//  _displaycontrol &= ~LCD_BLINKON;
//  LCcommand(LCD_DISPLAYCONTROL | _displaycontrol);
//}
//void LCblink() {
//  _displaycontrol |= LCD_BLINKON;
//  LCcommand(LCD_DISPLAYCONTROL | _displaycontrol);
//}
//
//// These commands scroll the display without changing the RAM
//void LCscrollDisplayLeft(void) {
//  LCcommand(LCD_CURSORSHIFT | LCD_DISPLAYMOVE | LCD_MOVELEFT);
//}
//void LCscrollDisplayRight(void) {
//  LCcommand(LCD_CURSORSHIFT | LCD_DISPLAYMOVE | LCD_MOVERIGHT);
//}
//
//// This is for text that flows Left to Right
//void LCleftToRight(void) {
//  _displaymode |= LCD_ENTRYLEFT;
//  LCcommand(LCD_ENTRYMODESET | _displaymode);
//}
//
//// This is for text that flows Right to Left
//void LCrightToLeft(void) {
//  _displaymode &= ~LCD_ENTRYLEFT;
//  LCcommand(LCD_ENTRYMODESET | _displaymode);
//}
//
//// This will 'right justify' text from the cursor
//void LCautoscroll(void) {
//  _displaymode |= LCD_ENTRYSHIFTINCREMENT;
//  LCcommand(LCD_ENTRYMODESET | _displaymode);
//}
//
//// This will 'left justify' text from the cursor
//void LCnoAutoscroll(void) {
//  _displaymode &= ~LCD_ENTRYSHIFTINCREMENT;
//  LCcommand(LCD_ENTRYMODESET | _displaymode);
//}
//
//// Allows us to fill the first 8 CGRAM locations
//// with custom characters
//void LCcreateChar(uint8_t location, uint8_t charmap[]) {
//  location &= 0x7; // we only have 8 locations 0-7
//  LCcommand(LCD_SETCGRAMADDR | (location << 3));
//  int i;
//  for (i=0; i<8; i++) {
//    LCwrite(charmap[i]);
//  }
//}
//
//inline void LCcommand(uint8_t value) {
//  LCsend(value, 0);
//}
//
//inline void LCwrite(uint8_t value) {
//  LCsend(value, 1);
//  return 1; // assume sucess
//}
//
//// write either command or data, with automatic 4/8-bit selection
//void LCsend(uint8_t value, uint8_t mode) {
//  //digitalWrite(_rs_pin, mode);
//  if (0 == (mode >> 0) & 1) {
//  	  lcdOut &= ~(1 << 1);
//  	  LCgpio();
//  	}
//  	else if (1 == (mode >> 0) & 1) {
//  	  lcdOut |= 1 << 1;
//  	  LCgpio();
//  	}
//  // if there is a RW pin indicated, set it low to Write
// // if (_rw_pin != 255) {
//  //  digitalWrite(_rw_pin, LOW);
//  //}
//
// // if (_displayfunction & LCD_8BITMODE) {
// //   write8bits(value);
//  //} else {
//    LCwrite4bits(value>>4);
//    LCwrite4bits(value);
//  //}
//}
//
//void LCpulseEnable(void) {
//  lcdOut &= ~(1 << 0); //EN LOW
//  LCgpio();
//  usleep(1);
//  //digitalWrite(_enable_pin, HIGH);
//  lcdOut |= 1 << 0; // EN HIGH
//  LCgpio();
//  usleep(1);   // enable pulse must be >450ns
//  lcdOut &= ~(1 << 0); //EN LOW
//  LCgpio();
//  usleep(100);   // commands need > 37us to settle
//}
//
//void LCwrite4bits(uint8_t value) {
//	int i;
//  for (i = 0; i < 4; i++) {
//	if (0 == (value >> i) & 1) {
//	  lcdOut &= ~(1 << i+2);
//	  LCgpio();
//	}
//	else if (1 == (value >> i) & 1) {
//	  lcdOut |= 1 << i+2;
//	  LCgpio();
//	}
//    //digitalWrite(_data_pins[i], (value >> i) & 0x01);
//  }
//
//  LCpulseEnable();
//}
//
//void LCwrite8bits(uint8_t value) {
//	int i;
//  for (i = 0; i < 8; i++) {
//	  if (0 == (value >> i) & 1) {
//	  	  lcdOut &= ~(1 << i+2);
//	  	  LCgpio();
//	  	}
//	  	else if (1 == (value >> i) & 1) {
//	  	  lcdOut |= 1 << i+2;
//	  	  LCgpio();
//	  	}
//	  //digitalWrite(_data_pins[i], (value >> i) & 0x01);
//  }
//
//  LCpulseEnable();
//}
//
//void LCgpio() {
//	XGpio_DiscreteWrite(&LCD16, 1, lcdOut);
//}
//*/
// */
