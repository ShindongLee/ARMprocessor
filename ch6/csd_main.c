//#pragma GCC target ("thumb")
#pragma GCC target ("arm")



void quicksort(int data[],int start, int end);//퀵소트 정의
int csd_main() {
	int indata[32] = {2, 0, -7, -1, 3, 8, -4, 10, //indata 선언과 값 초기화
						-9, -16, 15, 13, 1, 4, -3, 14,
						-8, -10, -15, 6, -13, -5, 9, 12,
						-11, -14, -6, 11, 5, 7, -2, -12 };
	int outdata[32]; //outdata 배열 선언

	for (int i = 0; i < 32; i++)
		outdata[i] = indata[i]; // outdata 배열에 indata값 집어넣기

	quicksort(outdata, 0, 31);// 퀵소트에 outdata배열과 처음 인덱스 0과 마지막 인덱스 31을 인자로 넣기

	return 0;
}

//#pragma GCC target ("thumb")
#pragma GCC target ("arm")

void quicksort(int data[],int start, int end) {
	if (start > end) // 마지막에 end가 start보다 작아지면 그 부분은 정렬완료
		return;
	int temp; // swap할때 값 담아두기
	int pivot = data[start]; // 피벗은 정렬하는 부분의 첫 값으로
	int i = start + 1; // i는 피벗의 다음인덱스
	int j = end; // j는 마지막 인덱스
	while (i <= j) {// i가 j보다 왼쪽에 있을때,
		while (data[i] < pivot) //data[i]>pivot인 값을 찾을때까지 i++
			i++;
		while (pivot < data[j]) //data[j]<pivot인 값을 찾을때까지 j--
			j--;
		if (i > j) {//i가 j보다 크다면  pivot빼고 정렬이 잘된 경우이므로
			temp = data[j]; //data[j]와 pivot을 바꿔준다.
			data[j] = pivot;
			data[start] = temp;
		}
		else { //j>=i이면서 data[i]>pivot>data[j]인 i, j를 찾은경우
			temp = data[i]; //data[i] 와  data[j] 를 바꿔준다
			data[i] = data[j];
			data[j] = temp;
		}
	}
	quicksort(data, start, j-1); // data[j] 가 현재 피벗이므로 j왼쪽과
	quicksort(data, j + 1, end); //j오른쪽 부분을 다시 퀵 정렬해준다.

}

