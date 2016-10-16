/**************************************************************************
* MPI Blocking communication around a ring Program - C Version
* 
* DESCRIPTION:  MPI Blocking communication around a ring example code.  C version.
* Write a program that will allow a processor to communicate its rank
* around a ring, the sum of all ranks should be accumulated and printed
* out by each processor.
**************************************************************************/


#include <stdio.h>
#include "mpi.h"
int main(int argc, char *argv[])		{
  int myrank, nprocs, leftid, rightid, val, sum, tmp;
  MPI_Status recv_status;
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &myrank);  
  MPI_Comm_size(MPI_COMM_WORLD, &nprocs);
  
  if((leftid =(myrank-1)) < 0) leftid = nprocs -1;
  if((rightid=(myrank+1)) == nprocs) rightid = 0;
  val = myrank;
  sum = 0;
  do {
    MPI_Send(&val,1,MPI_INT,rightid,99, MPI_COMM_WORLD); 
    MPI_Recv(&tmp,1, MPI_INT, leftid, 99, MPI_COMM_WORLD, &recv_status);
    val = tmp;
    sum += val;
  } while (val != myrank);
  
  printf("Proc %d sum = %d \n", myrank, sum);
  MPI_Finalize();			}
