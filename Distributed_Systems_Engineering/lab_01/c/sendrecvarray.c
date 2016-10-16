/**************************************************************************
* MPI Sending and receiving array Program - C Version
*
* DESCRIPTION:
**************************************************************************/


#include <stdio.h>
#include "mpi.h"
int main(int argc, char ** argv)
{
	int rank;
	int tag = 2;
	char message[13] = "Hello, world";

	MPI_Status status;
	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	if ( rank == 0 )
	{
	   MPI_Send(&message, 12, MPI_CHAR, 1, tag, MPI_COMM_WORLD);
	}
	else if ( rank == 1 )
	{
	   MPI_Recv(&message, 12, MPI_CHAR, 0, tag, MPI_COMM_WORLD, &status);
	   printf("Procesas %d : %s\n", rank, message);
	}

	MPI_Finalize();
}
