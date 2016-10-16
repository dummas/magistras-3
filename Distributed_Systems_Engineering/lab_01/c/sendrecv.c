/**************************************************************************
* MPI Sending and receiving variable - C Version
*
* DESCRIPTION:
**************************************************************************/

#include <stdio.h>
#include "mpi.h"
int main(int argc, char ** argv)
{
	int rank;
	int tag = 1;
	int A = 123456;

	MPI_Status status;
	MPI_Init(&argc, &argv);			// main thread
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	if ( rank == 0 )
	{
	   MPI_Send(&A, 1, MPI_INT, 1, tag, MPI_COMM_WORLD);
	   printf("Procesas %d : siuncia duomenis %d\n", rank, A);
	}
	else if ( rank == 1 )
	{
	   MPI_Recv(&A, 1, MPI_INT, 0, tag, MPI_COMM_WORLD, &status);
	   printf("Procesas %d : priima duomenis %d\n", rank, A);
	}

	// main thread
	MPI_Finalize();
}
