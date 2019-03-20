/*
 * csd_main.c
 *
 *  Created on: 2018. 4. 1.
 *      Author: user
 */


#include <stdio.h>
int csd_main(){


	unsigned char * sw; //pointer to switch input
	unsigned int i; // index of for loop

	sw = (unsigned char*) 0x41210000; // address of switch input

	if((*sw)>= 128){ //priority switch is sw7
		for(i=0;i<5000000;i++); //wait 100ms
			}
	else if((*sw)>= 64){ //priority switch is sw6
			for(i=0;i<10000000;i++); //wait 200ms
				}
	else if((*sw)>= 32){ //priority switch is sw5
				for(i=0;i<15000000;i++); //wait 300ms
					}
	else if((*sw)>= 16){ //priority switch is sw4
				for(i=0;i<20000000;i++); //wait 400ms
					}
	else if((*sw)>= 8){ //priority switch is sw3
				for(i=0;i<25000000;i++); //wait 500ms
					}
	else if((*sw)>= 4){ //priority switch is sw2
				for(i=0;i<30000000;i++); //wait 600ms
					}
	else if((*sw)>= 2){ //priority switch is sw1
				for(i=0;i<35000000;i++); //wait 700ms
					}
	else if((*sw)>= 1){ //priority switch is sw0
				for(i=0;i<40000000;i++); //wait 800ms
					}
	else {  //no switch is turned on
				for(i=0;i<50000000;i++); //wait 1 second
					}



	return 0;
}
