#ifndef INIT_H_INCLUDED
	#define INIT_H_INCLUDED

	//VS briedas, nes jam nepatinka fopen funkcija ir siulo taikyti savo specifine funkcija
	#ifdef _WIN64
		#define _CRT_SECURE_NO_DEPRECATE
	#endif
	#ifdef _WIN32
		#define _CRT_SECURE_NO_DEPRECATE
	#endif

	#include <stdio.h>
	#include <stdlib.h>

	#ifdef __APPLE__
		#include <OpenCL/opencl.h>
	#else
		#include <CL/cl.h>
	#endif

	cl_int err;
	cl_platform_id *platform(int n, int log);
	cl_device_id *device(cl_platform_id *platform_id, int n, int x, int y, int log);
	cl_context context_(cl_platform_id *platform_id, int n, cl_device_id *device_id, cl_int err);
	cl_command_queue commandqueue(cl_context context, cl_device_id *device_id, int x, cl_int err);
	cl_kernel  compile(char *name, char *kernelname, cl_context context, cl_device_id *device_id, int x, int log, cl_int err);
	void freeMem(cl_kernel kernel, cl_context context, cl_command_queue command_queue);

	void windows();

#endif