/**************************************************************************
* MPI Nonblocking Sending and receiving variable program - C Version
* 
* DESCRIPTION: 
**************************************************************************/

#include <stdio.h>
#include <mpi.h>

int main(int argc, char ** argv) 
{
    int rank;
    int size;
    int tag=1;
    int A;

    MPI_Status status;
    MPI_Request request;
 
    MPI_Init(&argc,&argv);				// init by main thread
    MPI_Comm_size(MPI_COMM_WORLD,&size);
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);

    request=MPI_REQUEST_NULL;

    if(rank == 0)
    {
      A=1234;
      MPI_Isend(&A,1,MPI_INT,1,tag,MPI_COMM_WORLD,&request);
    }

    if(rank == 1)
    {
        MPI_Irecv(&A,1,MPI_INT,0,tag,MPI_COMM_WORLD,&request);
    }

    MPI_Wait(&request,&status);

    if(rank == 0)
    {
      printf("procesas %d  issiunte %d\n",rank,A);
    }

    if(rank == 1)
    {
      printf("procesas %d  gavo %d\n",rank,A);
    }

    MPI_Finalize();					// disband by main thread
}
