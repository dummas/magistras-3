//VS brieda, nes jam nepatinka fopen funkcija ir siulo taikyti savo specifine
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

#define DATA_SIZE 10

int main()
{
	int i;
/******************** Ikrauname Kernel ************/
	FILE *fp;
	char fileName[] = "./hello.cl";
	char *KernelSource;
	size_t source_size;

	/* Load the source code containing the kernel*/
	fp = fopen(fileName, "r");
	if (!fp) {
		fprintf(stderr, "Failed to load kernel.\n");
		exit(1);
	}

	size_t programSize;
	fseek(fp, 0, SEEK_END);
	programSize = ftell(fp);
	rewind(fp);

	KernelSource = (char*)malloc(programSize+1);
	KernelSource[programSize] = '\0';
	source_size = fread(KernelSource, 1, programSize, fp);
	fclose(fp);
/****************************************************************************/

	/***************************RESURSU NUSTATYMAS**************************************/
	//retreives a list of platforms available
	//sarasa galimu irenginiu
	cl_platform_id platform_id[100];
	cl_uint num_of_platforms = 0;
	int j;
	

	if (clGetPlatformIDs(100, platform_id, &num_of_platforms) != CL_SUCCESS) {
		printf("Unable to get platform_id\n");
		return 1;
	}

	j = num_of_platforms;
	printf("=== %d OpenCL platform(s) found: ===\n", num_of_platforms);
	for (i = 0; i<j; i++)
	{
		char buffer[10240];
		printf("  -- %d --\n", i);
		clGetPlatformInfo(platform_id[i], CL_PLATFORM_PROFILE, 10240, buffer, NULL);
		printf("  PROFILE = %s\n", buffer);
		clGetPlatformInfo(platform_id[i], CL_PLATFORM_VERSION, 10240, buffer, NULL);
		printf("  VERSION = %s\n", buffer);
		clGetPlatformInfo(platform_id[i], CL_PLATFORM_NAME, 10240, buffer, NULL);
		printf("  NAME = %s\n", buffer);
		clGetPlatformInfo(platform_id[i], CL_PLATFORM_VENDOR, 10240, buffer, NULL);
		printf("  VENDOR = %s\n", buffer);
		clGetPlatformInfo(platform_id[i], CL_PLATFORM_EXTENSIONS, 10240, buffer, NULL);
		printf("  EXTENSIONS = %s\n", buffer);
	}
	printf("\n");
	
	//try to get a supported GPU device
	//suzinome is saraso ar yra palaikomas grafinis procesorius; gali buti ir procesorius ar dar kazkas
	//CL_DEVICE_TYPE_GPU; CL_DEVICE_TYPE_CPU; CL_DEVICE_TYPE_ALL - paskutinis geriausias
	cl_device_id device_id[100];
	cl_uint num_of_devices = 0;

	if (clGetDeviceIDs(platform_id[0], CL_DEVICE_TYPE_ALL, 100, device_id, &num_of_devices) != CL_SUCCESS) {
		printf("Unable to get device_id\n");
		return 1;
	}

	j = num_of_devices;
	printf("=== %d OpenCL device(s) found on platform:\n", num_of_devices);
	for (i = 0; i<10; i++)
	{
		char buffer[10240];
		cl_uint buf_uint;
		cl_ulong buf_ulong;
		printf("  -- %d --\n", i);
		clGetDeviceInfo(device_id[i], CL_DEVICE_NAME, sizeof(buffer), buffer, NULL);
		printf("  DEVICE_NAME = %s\n", buffer);
		clGetDeviceInfo(device_id[i], CL_DEVICE_VENDOR, sizeof(buffer), buffer, NULL);
		printf("  DEVICE_VENDOR = %s\n", buffer);
		clGetDeviceInfo(device_id[i], CL_DEVICE_VERSION, sizeof(buffer), buffer, NULL);
		printf("  DEVICE_VERSION = %s\n", buffer);
		clGetDeviceInfo(device_id[i], CL_DRIVER_VERSION, sizeof(buffer), buffer, NULL);
		printf("  DRIVER_VERSION = %s\n", buffer);
		clGetDeviceInfo(device_id[i], CL_DEVICE_MAX_COMPUTE_UNITS, sizeof(buf_uint), &buf_uint, NULL);
		printf("  DEVICE_MAX_COMPUTE_UNITS = %u\n", (unsigned int)buf_uint);
		clGetDeviceInfo(device_id[i], CL_DEVICE_MAX_CLOCK_FREQUENCY, sizeof(buf_uint), &buf_uint, NULL);
		printf("  DEVICE_MAX_CLOCK_FREQUENCY = %u\n", (unsigned int)buf_uint);
		clGetDeviceInfo(device_id[i], CL_DEVICE_GLOBAL_MEM_SIZE, sizeof(buf_ulong), &buf_ulong, NULL);
		printf("  DEVICE_GLOBAL_MEM_SIZE = %llu\n", (unsigned long long)buf_ulong);
	}
	printf("\n");

	
	//context properties list - must be terminated with 0
	//nustatome kokia platforma naudosime
	//galime ir nekurti properties, tuomet context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &err);
	cl_context_properties properties[3];
	properties[0] = CL_CONTEXT_PLATFORM;
	properties[1] = (cl_context_properties)platform_id[0];
	properties[2] = 0;
	
	//create a context with the GPU device
	cl_context context;
	cl_int err;
	context = clCreateContext(properties, 1, device_id, NULL, NULL, &err);
	
	//create command quene using the context and device
	//cia butinai turime nuroditi kokiame itaise vyks programa ir todel device_id[0]
	//jeigu norime vykdyti daugiau programu su kitais itaisais tuomet reikia sukurti papildomas komandu eiles tiems itaisams
	cl_command_queue command_queue;
	command_queue = clCreateCommandQueue(context, device_id[0], 0, &err);

	/**********************************RESURSU NUSTATYMO PABAIGA*******************************************/

	//**********Enkapsuliavimas, kompiliavimas ir duomenu argumentais priskirymas*******************************/
	//create a program from the kernel source code
	//sitas program objektas enkapsiliuoja, t.y., itraukia i save kernel programa ir informacija apie iranga per context, bei dar kt.
	cl_program program;
	program = clCreateProgramWithSource(context, 1, (const char**) &KernelSource, NULL, &err);
	
	//compile the program
	// programa, kartu su kitais parametrais, yra kompiliuojama
	//char *buildoptions = "-DGPU_DUAL_ENABLED -cl-opt-disbale"; //galime surasyti preprocesorius kompiliuojant kerneliui
	if (clBuildProgram(program, 0, NULL, NULL, NULL, NULL) != CL_SUCCESS)
	{
		printf("Error building program\n");
		
		//kompiliavimo logo jei mums reikia
		//kazkodeltai nieko nerodo konsoleje ?
		char buffer[4096];
		size_t length;
		clGetProgramBuildInfo(program, device_id[0], CL_PROGRAM_BUILD_LOG, sizeof(buffer), buffer, & length);
		printf("%s\n", buffer);
		//*****************
		
		return 1;
	}
	
	//specify which kernel from the program to execute
	//kai sekmingai sukompiliuojama programa si funkcija enkapsuliuoja kernel funkcija su 
	//norimais argumentais ir pasiuncia i komandine eile vykdymui
	cl_kernel kernel;
	kernel = clCreateKernel(program, "hello", &err); //hello yra funkcijos vardas surisamas su __kernel
	
	//create buffers for the input and output
	cl_mem input, output;
	input = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(float) * DATA_SIZE, NULL, NULL);
	output = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(float)* DATA_SIZE, NULL, NULL);
	
	//load data into the input buffer
	float inputData[DATA_SIZE] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
	clEnqueueWriteBuffer(command_queue, input, CL_TRUE, 0, sizeof(float)* DATA_SIZE, inputData, 0, NULL, NULL);
	
	//set argument list for the kernel command
	//priskiriame kerneliui argumentus su duomenimis
	size_t global;
	clSetKernelArg(kernel, 0, sizeof(cl_mem), &input);
	clSetKernelArg(kernel, 1, sizeof(cl_mem), &output);
	global = DATA_SIZE;
	/***********************************************************************************************************/


	/****************************Programos vykdymas*************************************************************/
	//enqueue the kernel command for execution
	//po kernel nurodomos problemos dysis. siuo atveju 1, nes vienmatis masyvas. Matricoms nurodome 2, o kubams 3
	//jei turime matrica, tarkim paveiksla kurio dysis 512*512, tai penktas parametras nurodomas pvz size_t global[2]={512,512};
	//sestas parametras pasko kiek grupiu dirbs, pvz. yra 64 darbai kurie sugrupuoti po 8x8 tuomet size_t local[2] = {8,8};
	//7 ir 8 parametrai nusako kokia tvarka komandu eileje bus vykdomi kerneliai
	//paskutinis parametras leidzia atlikus darba sukurti ivyki, pagal kuri kiti kerneliai gali orentuoti savo 
	//darba - palaukti jei reikia rezultatu ir pan.
	clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global, NULL, 0, NULL, NULL);
	clFinish(command_queue);
	
	//copy the results from out of the output buffer
	float results[DATA_SIZE] = {0};
	clEnqueueReadBuffer(command_queue, output, CL_TRUE, 0, sizeof(float)* DATA_SIZE, results, 0, NULL, NULL);
	
	//print the results
	printf("output: \n");
	for (i = 0; i < DATA_SIZE; i++) {
		printf("%f \n", results[i]);
	}
	
	//cleanup - release OpenCL resources
	clReleaseMemObject(input);
	clReleaseMemObject(output);
	clReleaseProgram(program);
	clReleaseKernel(kernel);
	clReleaseCommandQueue(command_queue);
	clReleaseContext(context);
	
	#ifdef _WIN64
		system("PAUSE");
	#else
		#ifdef _WIN32
			system("PAUSE");
		#endif
	#endif
	return 0;
}

