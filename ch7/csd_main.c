/*
 * csd_main.c

 */

char time[50];
char* csd_main(int a, int b, int c)
{

	char buf;
	buf = (a % 10) + 48;//hour�� 1���ڸ���
	a /= 10;
	time[1] = buf;

	buf = a + 48; //hour�� 10���ڸ���
	time[0] = buf;

	time[2] = 32; //space
	time[3] = ':';//:
	time[4] = 32; //space

	buf = (b % 10) + 48; //minute�� 1���ڸ���
	b /= 10;
	time[6] = buf;

	buf = b + 48; //minute�� 10���ڸ���
	time[5] = buf;

	time[7] = 32; //space
	time[8] = ':';//:
	time[9] = 32; //space

	buf = (c % 10) + 48; //second�� 1���ڸ���
	c /= 10;
	time[11] = buf;

	buf = c + 48; //second�� 10���ڸ���
	time[10] = buf;

	time[12] = '\0';//���ڿ��� ���� �˸��� null

 return (char*)&time;

}
