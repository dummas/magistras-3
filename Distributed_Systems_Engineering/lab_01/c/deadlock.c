/**************************************************************************
* MPI Deadlock Program - C Version
*
* DESCRIPTION:  MPI Deadlock example code.  C version.
*   Here we have two examples
**************************************************************************/

/*
#include "mpi.h"
#include "stdio.h"

#define N 65536

int main (int argc, char *argv[])
{
   int rank, n_proc, right, left, buf[N];
   MPI_Status stat;

   MPI_Init (&argc, &argv);
   MPI_Comm_rank (MPI_COMM_WORLD, &rank);
   MPI_Comm_size (MPI_COMM_WORLD, &n_proc);

   right = (rank + 1 == n_proc) ? 0 : rank + 1;
   left = (rank - 1 < 0) ? n_proc - 1 : rank - 1;

   MPI_Send (buf, N, MPI_INT, right, 0, MPI_COMM_WORLD);
   MPI_Recv (buf, N, MPI_INT, left, 0, MPI_COMM_WORLD, &stat);

   printf ("Rank %d sent message to rank %d\n", rank, right);
   printf ("Rank %d received message from rank %d\n", rank, left);

   MPI_Finalize ();
}
*/

/*
#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

// BIG defines how many integers we will send in one MPI message
//#define BIG 1000 // doesn't deadlock with OpenMPI
#define BIG 1000000 // deadlocks with OpenMPI
// If the larger number doesn't deadlock, make it bigger
// It should eventually break, unless your implementation of MPI is crazy

int main(int argc, char *argv[]) {
    int rank, size;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int *i = malloc(sizeof(int) * BIG);
    i[0] = rank;
    i[BIG - 1] = size * (rank + 1);

    printf("Node %d is trying to send\n", rank);
    MPI_Send(i, BIG, MPI_INT, (rank + 1) % size, 1, MPI_COMM_WORLD);
    printf("Node %d sent %d %d successfully\n", rank, i[0], i[BIG - 1]);

    MPI_Recv(i, BIG, MPI_INT, (rank - 1) % size, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    printf("Node %d received %d %d from node %d\n", rank, i[0], i[BIG - 1], (size + rank - 1) % size);

    MPI_Finalize();
    return 0;
}
*/

#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

// BIG defines how many integers we will send in one MPI message
//#define BIG 1000 // doesn't deadlock with OpenMPI
#define BIG 100000 // deadlocks with OpenMPI
// If the larger number doesn't deadlock, make it bigger
// It should eventually break, unless your implementation of MPI is crazy

int main(int argc, char *argv[])
{
    int rank;
    int size;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int *i = malloc(sizeof(int) * BIG);			// allocate block in memory
    i[0] = rank;					// first block value rank
    i[BIG - 1] = size * (rank + 1);			//

    printf("Node %d is trying to send\n", rank);		// priority of process
    MPI_Request req;
    MPI_Isend(i, BIG, MPI_INT, (rank + 1) % size, 1, MPI_COMM_WORLD, &req);	// send
    printf("Node %d began send of %d %d successfully\n", rank, i[0], i[BIG - 1]); // sent
    MPI_Wait(&req, MPI_STATUS_IGNORE);						// check
    printf("Node %d completed send\n", rank);

    MPI_Recv(i, BIG, MPI_INT, (rank - 1) % size, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    printf("Node %d received %d %d from node %d\n", rank, i[0], i[BIG - 1], (size + rank - 1) % size);

    MPI_Finalize();
    return 0;
}
