#ifndef MASYVAI_H_INCLUDED
	#define MASYVAI_H_INCLUDED

	#include <stdio.h>
	#include <stdlib.h>

	//masyvai/vektoriai
	double* new_vector_dou(int n);
	float* new_vector_flo(int n);
	int* new_vector_int(int n);

	//matricos
	double** new_matrix_dou(int n, int m);
	float** new_matrix_flo(int n, int m);
	int** new_matrix_int(int n, int m);

#endif