#include "main.h"

void freeMem(cl_kernel kernel, cl_context context, cl_command_queue command_queue)
{
	clReleaseKernel(kernel);
	clReleaseCommandQueue(command_queue);
	clReleaseContext(context);
}

cl_platform_id *platform(int n, int log)
{
	//retreives a list of platforms available
	//sarasa galimu irenginiu
	cl_platform_id *platform_id;
	platform_id = malloc(n * sizeof(cl_platform_id *));
	if (NULL == platform_id){
		free(platform_id);
		printf("Memory allocation failed while allocating for platform_id.\n");
		exit(-1);
	}
	cl_uint num_of_platforms = 0;
	int i, j;


	if (clGetPlatformIDs(n, platform_id, &num_of_platforms) != CL_SUCCESS) {
		printf("Unable to get platform_id\n");
		exit(-1); //return 1; isveda warning
	}

	if (log == 1) {

		j = num_of_platforms;
		printf("=== %d OpenCL platform(s) found: ===\n", num_of_platforms);
		for (i = 0; i < j; i++)
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
	}

	return platform_id;
}

cl_device_id *device(cl_platform_id *platform_id, int n, int x, int y, int log)
{
	int i, j;
	//try to get a supported GPU device
	//suzinome is saraso ar yra palaikomas grafinis procesorius; gali buti ir procesorius ar dar kazkas
	//CL_DEVICE_TYPE_GPU; CL_DEVICE_TYPE_CPU; CL_DEVICE_TYPE_ALL - paskutinis geriausias
	cl_device_id *device_id;

	device_id = malloc(n * sizeof(cl_platform_id *));
	if (NULL == device_id){
		free(device_id);
		printf("Memory allocation failed while allocating for device_id.\n");
		exit(-1);
	}

	cl_uint num_of_devices = 0;
	if (clGetDeviceIDs(platform_id[x], y, n, device_id, &num_of_devices) != CL_SUCCESS) {
		printf("Unable to get device_id\n");
		exit(-1); //return 1; isveda warning
	}

	if (log == 1) {
		j = num_of_devices;
		printf("=== %d OpenCL device(s) found on platform:\n", num_of_devices);
		for (i = 0; i < j; i++)
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
	}
	return device_id;
}


cl_context context_(cl_platform_id *platform_id, int n, cl_device_id *device_id, cl_int err)
{
	//context properties list - must be terminated with 0
	//nustatome kokia platforma naudosime
	//galime ir nekurti properties, tuomet context = clCreateContext(NULL, 1, &device_id, NULL, NULL, &err);
	cl_context_properties properties[3];
	properties[0] = CL_CONTEXT_PLATFORM;
	properties[1] = (cl_context_properties)platform_id[n];
	properties[2] = 0;

	//create a context with the GPU device
	cl_context context;

	context = clCreateContext(properties, 1, device_id, NULL, NULL, &err);

	free(platform_id);

	return context;
}

cl_command_queue commandqueue(cl_context context, cl_device_id *device_id, int x, cl_int err)
{
	//create command quene using the context and device
	//cia butinai turime nuroditi kokiame itaise vyks programa ir todel device_id[0]
	//jeigu norime vykdyti daugiau programu su kitais itaisais tuomet reikia sukurti papildomas komandu eiles tiems itaisams
	cl_command_queue command_queue;
	command_queue = clCreateCommandQueue(context, device_id[x], 0, &err);

	return command_queue;
}

cl_kernel compile(char *name, char *kernelname, cl_context context, cl_device_id *device_id, int x, int log, cl_int err)
{
	//******************** Ikrauname Kernel ************
	FILE *fp;
	//char fileName[] = "./hello.cl";
	char *KernelSource;
	size_t source_size;
	// Load the source code containing the kernel
	//fp = fopen(fileName, "r");
	fp = fopen(name, "r");
	if (!fp) {
		fprintf(stderr, "Failed to load kernel.\n");
		exit(1);
	}

	size_t programSize;
	fseek(fp, 0, SEEK_END);
	programSize = ftell(fp);
	rewind(fp);

	KernelSource = (char*)malloc(programSize + 1);
	KernelSource[programSize] = '\0';
	source_size = fread(KernelSource, 1, programSize, fp);
	fclose(fp);
	//****************************************************************************

	//create a program from the kernel source code
	//sitas program objektas enkapsiliuoja, t.y., itraukia i save kernel programa ir informacija apie iranga per context, bei dar kt.
	cl_program program;
	program = clCreateProgramWithSource(context, 1, (const char**)&KernelSource, NULL, &err);

	//compile the program
	// programa, kartu su kitais parametrais, yra kompiliuojama
	//char *buildoptions = "-DGPU_DUAL_ENABLED -cl-opt-disbale"; //galime surasyti preprocesorius kompiliuojant kerneliui
	if (clBuildProgram(program, 0, NULL, NULL, NULL, NULL) != CL_SUCCESS)
	{
		printf("Error building program\n");

		if (log == 0)
		{
			//kompiliavimo logo jei mums reikia
			//kazkodeltai nieko nerodo konsoleje ?
			char buffer[4096];
			size_t length;
			clGetProgramBuildInfo(program, device_id[0], CL_PROGRAM_BUILD_LOG, sizeof(buffer), buffer, &length);
			printf("%s\n", buffer);
			//*****************
		}
		exit(-1);
	}

	free(device_id);

	//specify which kernel from the program to execute
	//kai sekmingai sukompiliuojama programa si funkcija enkapsuliuoja kernel funkcija su 
	//norimais argumentais ir pasiuncia i komandine eile vykdymui
	cl_kernel kernel;
	kernel = clCreateKernel(program, kernelname, &err); //hello yra funkcijos vardas surisamas su __kernel

	clReleaseProgram(program);

	return kernel;
}



void windows()
{
	#ifdef _WIN64
		system("PAUSE");
	#else
		#ifdef _WIN32
			system("PAUSE");
		#endif
	#endif
}