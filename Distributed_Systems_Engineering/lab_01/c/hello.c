/**************************************************************************
* MPI Hello World Program - C Version
* 
* DESCRIPTION:  
**************************************************************************/

#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[]) 
{
  int size;
  int rank;
	
  //nebutina
  int namelen;
  char processor_name[MPI_MAX_PROCESSOR_NAME];

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  
  //nebutina
  MPI_Get_processor_name(processor_name, &namelen); 

  printf("Procesas %d kompiuteryje %s is %d\n", rank, processor_name, size);

  MPI_Finalize();
}
