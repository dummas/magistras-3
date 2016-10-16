
all: hello sendrecv sendrecvarray isendirecv deadlock array

hello:
	mpicc -lm -o hello hello.c

sendrecv:
	mpicc -lm -o sendrecv sendrecv.c

sendrecvarray:
	mpicc -lm -o sendrecvarray sendrecvarray.c

isendirecv:
	mpicc -lm -o isendirecv	isendirecv.c

deadlock:
	mpicc -lm -o deadlock deadlock.c

array:
	mpicc -lm -o array array.c

run-hello:
	mpiexec -n 10 ./hello

run-sendrecv:
	mpiexec -n 2 ./sendrecv

run-sendrecvarray:
	mpiexec -n 2 ./sendrecvarray

run-isendirecv:
	mpiexec -n 2 ./isendirecv

run-deadlock:
	mpiexec -n 256 ./deadlock

run-array:
	mpiexec -n 10 ./array

clean:
	rm hello sendrecv sendrecvarray isendirecv deadlock array
