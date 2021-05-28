//#pragma GCC target ("thumb")
#pragma GCC target ("arm")



void quicksort(int data[],int start, int end);//����Ʈ ����
int csd_main() {
	int indata[32] = {2, 0, -7, -1, 3, 8, -4, 10, //indata ����� �� �ʱ�ȭ
						-9, -16, 15, 13, 1, 4, -3, 14,
						-8, -10, -15, 6, -13, -5, 9, 12,
						-11, -14, -6, 11, 5, 7, -2, -12 };
	int outdata[32]; //outdata �迭 ����

	for (int i = 0; i < 32; i++)
		outdata[i] = indata[i]; // outdata �迭�� indata�� ����ֱ�

	quicksort(outdata, 0, 31);// ����Ʈ�� outdata�迭�� ó�� �ε��� 0�� ������ �ε��� 31�� ���ڷ� �ֱ�

	return 0;
}

//#pragma GCC target ("thumb")
#pragma GCC target ("arm")

void quicksort(int data[],int start, int end) {
	if (start > end) // �������� end�� start���� �۾����� �� �κ��� ���ĿϷ�
		return;
	int temp; // swap�Ҷ� �� ��Ƶα�
	int pivot = data[start]; // �ǹ��� �����ϴ� �κ��� ù ������
	int i = start + 1; // i�� �ǹ��� �����ε���
	int j = end; // j�� ������ �ε���
	while (i <= j) {// i�� j���� ���ʿ� ������,
		while (data[i] < pivot) //data[i]>pivot�� ���� ã�������� i++
			i++;
		while (pivot < data[j]) //data[j]<pivot�� ���� ã�������� j--
			j--;
		if (i > j) {//i�� j���� ũ�ٸ�  pivot���� ������ �ߵ� ����̹Ƿ�
			temp = data[j]; //data[j]�� pivot�� �ٲ��ش�.
			data[j] = pivot;
			data[start] = temp;
		}
		else { //j>=i�̸鼭 data[i]>pivot>data[j]�� i, j�� ã�����
			temp = data[i]; //data[i] ��  data[j] �� �ٲ��ش�
			data[i] = data[j];
			data[j] = temp;
		}
	}
	quicksort(data, start, j-1); // data[j] �� ���� �ǹ��̹Ƿ� j���ʰ�
	quicksort(data, j + 1, end); //j������ �κ��� �ٽ� �� �������ش�.

}

