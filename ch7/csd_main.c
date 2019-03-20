/*
 * csd_main.c

 */

char time[50];
char* csd_main(int a, int b, int c)
{

	char buf;
	buf = (a % 10) + 48;//hour의 1의자리수
	a /= 10;
	time[1] = buf;

	buf = a + 48; //hour의 10의자리수
	time[0] = buf;

	time[2] = 32; //space
	time[3] = ':';//:
	time[4] = 32; //space

	buf = (b % 10) + 48; //minute의 1의자리수
	b /= 10;
	time[6] = buf;

	buf = b + 48; //minute의 10의자리수
	time[5] = buf;

	time[7] = 32; //space
	time[8] = ':';//:
	time[9] = 32; //space

	buf = (c % 10) + 48; //second의 1의자리수
	c /= 10;
	time[11] = buf;

	buf = c + 48; //second의 10의자리수
	time[10] = buf;

	time[12] = '\0';//문자열의 끝을 알리는 null

 return (char*)&time;

}
