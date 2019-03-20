#define csd_LED_ADDR	0x41200000

.extern csd_main

.align 8

// Our interrupt vector table
csd_entry:
	b csd_reset
	b .
	b .
	b .
	b .
	b .
	b csd_irq
	b .

.global main
csd_reset:
main:



ldr r10, =#0x41200000 // address of LEDs
ldr r11, =#0x41210000 // address of Switches
mov r12, #0b00000001 // next value of LEDs

loop:
bl csd_main // check the switch input
strb r12, [r10] // turn on next leds

cmp r12, #0b10000000 // if leds output is 10000000 (if ld7 is turned on)
beq jump			 // next leds output is 00000001

mov r12, r12, LSL#1  // r12=r12*2, turn on next led

b loop

jump:
mov r12, #1 //set leds to 00000001
b loop



.data
.align 4



// Normal Interrupt Service Routine
csd_irq:
	b .
