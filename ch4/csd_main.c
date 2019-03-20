/*
 * csd_main.c
 *
 *  Created on: 2018. 4. 1.
 *      Author: user
 */


#include <stdio.h>


int csd_main(){

	int i = 0; // index for loop

	unsigned char *select;
	select = (unsigned char*) 0x00101af0; //(*select) = keyboard_input (1~8)


	if((*select)<8){ //wait 100ms ~ 700ms
	for(i = 0;i<(*select)*5000000;i++);
	}

	else if((*select) == 8){ //if keyboard_input == 8, then wait 1 second
		for(i=0;i<50000000;i++)
			;
}

	return 0;
}
