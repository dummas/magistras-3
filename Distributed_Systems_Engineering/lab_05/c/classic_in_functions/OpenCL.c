#include "main.h"

int main()
{
	int i;

	//***************************RESURSU NUSTATYMAS**************************************

	cl_platform_id *platform_id;
	platform_id = platform(100, 0);

	cl_device_id *device_id;
	device_id = device(platform_id, 100, 0, CL_DEVICE_TYPE_ALL, 0);

	cl_context context;
	context = context_(platform_id, 0, device_id, err);

	cl_command_queue command_queue;
	command_queue = commandqueue(context, device_id, 0, err);

	//mano PC 0 yra GPU, o 1 CPU, jeigu device pasirinkta ALL device variantas (0), todel galiu sukurti programu vykdymo eile dvejiems irenginiams
	//cl_command_queue command_queue_CPU;
	//command_queue_CPU = commandqueue(context, device_id, 1, err);

	//**********************************RESURSU NUSTATYMO PABAIGA*******************************************

	//**********ENKAPSULIAVIMAS, KOMPILIAVIMAS IR DUOMENU ARGUMENTAMS PSRISKYRIMAS*************************
	
	cl_kernel kernel;
	kernel = compile("./hello.cl", "hello", context, device_id, 0, 0, err);

	//gali buti sukurta programa is kito failo ir su kitu pavadinimu, bei priskirta kitam irenginiui
	//cl_kernel kernel1;
	//kernel1 = compile("./hello.cl", "hello", context, device_id, 1, 0, err);
	
	//create buffers for the input and output
	cl_mem input, output;
	input = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(float) * 10, NULL, NULL);
	output = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(float)* 10, NULL, NULL);
	
	//load data into the input buffer
	float inputData[10] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
	clEnqueueWriteBuffer(command_queue, input, CL_TRUE, 0, sizeof(float)* 10, inputData, 0, NULL, NULL);
	
	//set argument list for the kernel command
	//priskiriame kerneliui argumentus su duomenimis
	clSetKernelArg(kernel, 0, sizeof(cl_mem), &input);
	clSetKernelArg(kernel, 1, sizeof(cl_mem), &output);
	/***********************************************************************************************************/


	/****************************Programos vykdymas*************************************************************/
	//enqueue the kernel command for execution
	//po kernel nurodomos problemos dysis. siuo atveju 1, nes vienmatis masyvas. Matricoms nurodome 2, o kubams 3
	//jei turime matrica, tarkim paveiksla kurio dysis 512*512, tai penktas parametras nurodomas pvz size_t global[2]={512,512};
	//sestas parametras pasko kiek grupiu dirbs, pvz. yra 64 darbai kurie sugrupuoti po 8x8 tuomet size_t local[2] = {8,8};
	//7 ir 8 parametrai nusako kokia tvarka komandu eileje bus vykdomi kerneliai
	//paskutinis parametras leidzia atlikus darba sukurti ivyki, pagal kuri kiti kerneliai gali orentuoti savo 
	//darba - palaukti jei reikia rezultatu ir pan.
	size_t global;
	global = 10;
	clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global, NULL, 0, NULL, NULL);
	clFinish(command_queue);
	
	//copy the results from out of the output buffer
	float results[10] = {0};
	clEnqueueReadBuffer(command_queue, output, CL_TRUE, 0, sizeof(float)* 10, results, 0, NULL, NULL);
	
	//print the results
	printf("output: \n");
	for (i = 0; i < 10; i++) {
		printf("%f \n", results[i]);
	}
	
	//cleanup - release OpenCL resources
	clReleaseMemObject(input);
	clReleaseMemObject(output);
	freeMem(kernel, context, command_queue);
	
	windows();

	return 0;
}

