#include "masyvai.h"

//funkcija kuria double tipo dinamini vektoriu
double* new_vector_dou(int n)
{
	int i;
	double* x = (double*)malloc(n*sizeof(double));
	if (NULL == x) {
		free(x);
		printf("Memory allocation failed while allocating for X[].\n");
		exit(-1);
	}
	for (i = 0; i<n; i++)
		x[i] = 0;
	return x;
}

//funkcija kuria int tipo dinamini vektoriu
int* new_vector_int(int n)
{
	int i;
	int *x = (int*)malloc(n*sizeof(int));
	if (NULL == x){
		free(x);
		printf("Memory allocation failed while allocating for X[].\n");
		exit(-1);
	}
	for (i = 0; i<n; i++)
		x[i] = 0;
	return x;
}

//funkcija kuria float tipo dinamini vektoriu
float* new_vector_flo(int n)
{
	int i;
	float *x = (float*)malloc(n*sizeof(float));
	if (NULL == x){
		free(x);
		printf("Memory allocation failed while allocating for X[].\n");
		exit(-1);
	}
	for (i = 0; i<n; i++)
		x[i] = 0;
	return x;
}

//funkcija kuria double tipo dinamine matrica
double** new_matrix_dou(int n, int m)
{
	int i, j;
	double **x; //elementu koeficientu matrica
	x = (double**)malloc(n *sizeof(double*));
	if (NULL == x) {
		free(x);
		printf("Memory allocation failed while allocating for X[].\n");
		exit(-1);
	}
	for (i = 0; i<n; i++) {
		x[i] = (double*)malloc(m *sizeof(double));
		if (NULL == x[i]) {
			free(x[i]);
			printf("Memory allocation failed while allocating for X[][].\n");
			printf("choose lower n or m value.\n");
			exit(-1);
		}
	}
	for (i = 0; i<n; i++) {
		for (j = 0; j<m; j++) {
			x[i][j] = 0;
		}
	}
	return x;
}

//funkcija kuria float tipo dinamine matrica
float** new_matrix_flo(int n, int m)
{
	int i, j;
	float **x; //elementu koeficientu matrica
	x = (float**)malloc(n *sizeof(float*));
	if (NULL == x) {
		free(x);
		printf("Memory allocation failed while allocating for X[].\n");
		exit(-1);
	}
	for (i = 0; i<n; i++)
	{
		x[i] = (float*)malloc(m *sizeof(float));
		if (NULL == x[i]) {
			free(x[i]);
			printf("Memory allocation failed while allocating for X[][].\n");
			printf("choose lower n or m value.\n");
			exit(-1);
		}
	}
	for (i = 0; i<n; i++){
		for (j = 0; j<m; j++) {
			x[i][j] = 0;
		}
	}
	return x;
}

int** new_matrix_int(int n, int m)
{
	int i, j;
	int **x; //elementu koeficientu matrica
	x = (int**)malloc(n *sizeof(int*));
	if (NULL == x){
		free(x);
		printf("Memory allocation failed while allocating for X[].\n");
		exit(-1);
	}
	for (i = 0; i<n; i++) {
		x[i] = (int*)malloc(m *sizeof(int));
		if (NULL == x[i]) {
			free(x[i]);
			printf("Memory allocation failed while allocating for X[][].\n");
			printf("choose lower n or m value.\n");
			exit(-1);
		}
	}
	for (i = 0; i<n; i++) {
		for (j = 0; j<m; j++) {
			x[i][j] = 0;
		}
	}
	return x;
}