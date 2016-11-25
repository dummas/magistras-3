# Paskirstytų sistemų inžinerija

#### CUDA/OpenCL
#### Laboratorinis darbas 5, AKSfm-15, Maksim Norkin

## Užduotis

Susidiegti OpenCL, sukompliuoti, paleisti ir išnagrinėti ``hello`` programas ant MacOS platformos.

## Bibliotekos diegimas

Mac operacinėje sistemoje, OpenCL bibliotekos ateina jau su pačia operacine sistema, todėl nieko diegti nereikia.

Vienintelis pakeitimas nuo kitų aplinkų yra ``gcc``, vietoj 

    -lOpenCL
    
argumento kompiliavimo metu, yra paduodamas

    -framework OpenCL
    
Ir visa komandinė eilutė, kuri sukompiliuoja OpenCL išeitinį kodą, atrodo taip

    gcc -o hello Hello.c -framework OpenCL    

## Programos hello nagrinėjimas
 
### c dalis

Pati pirma programa susideda iš dviejų dalių. Pirma dalis yra C programa, kuri elgiasi kaip OpenCL programos prižiūrėtojas. Jinai peržiūri ar sistemoje yra grafinių posistemių, nusprendžią kurią grafinę posistemę naudoti programos paleidimui, įkelia programos branduolį, suformuoja programos argumentus, perduoda juos visus į programos posistemę ir pateikia programos rezultatus.

Programos kodas yra nuskaitymas vykdomas per šias eilutes

    FILE *fp;
    char fileName[] = "./hello.cl";
    char *KernelSource;
    size_t source_size;
    source_size = fread(KernelSource, 1, programSize, fp);
    
kur ``programSize`` yra pačios programos dydis, kuris yra nuskaitomas pagal programos išeities kodo dydį.

Toliau yra identifikuojamos galimos platformos

    cl_platform_id platform_id[100];
    cl_uint num_of_platforms = 0;
    clGetPlatformIDs(100, platform_id, &num_of_platforms)
    
Iš kurių paskui yra aiškinamasi GPU palaikymo

    cl_device_id device_id[100];
    cl_uint num_of_devices = 0;
    clGetDeviceIDs(platform_id[0], CL_DEVICE_TYPE_ALL, 100, device_id, &num_of_devices)
    
Tolimesnis žingsnis yra naudojamo įrenginio konteksto sukūrimas

    cl_context context;
    cl_int err;
    context = clCreateContext(properties, 1, device_id, NULL, NULL, &err);

kuris yra panaudojamas sukuriant eiles

    cl_command_queue command_queue;
    command_queue = clCreateCommandQueue(context, device_id[0], 0, &err);
    
Eilės yra vienintelė sąsaja su pačiu grafinės posistemės kontekstu.

Sekantis žingsnis yra programos enkapsulavimas į kontekstą

    cl_program program;
    program = clCreateProgramWithSource(context, 1, (const char**) &KernelSource, NULL, &err);
    
ir sukompiliuojama

    clBuildProgram(program, 0, NULL, NULL, NULL, NULL)
    
Iš įkeltos programos pasirenkama norima funkcija vykdymui

    cl_kernel kernel;
    kernel = clCreateKernel(program, "hello", &err);
    
Komunikacijai per eiles yra reikalingi buferiai, kurių pagalba yra įkraunami duomenys vykdymui ir nuskaitomas pats rezultatas

    cl_mem input, output;
    input = clCreateBuffer(context, CL_MEM_READ_ONLY, sizeof(float) * DATA_SIZE, NULL, NULL);
    output = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(float)* DATA_SIZE, NULL, NULL);
    
Įkeliam duomenis į įėjimo buferį

    float inputData[DATA_SIZE] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    clEnqueueWriteBuffer(command_queue, input, CL_TRUE, 0, sizeof(float)* DATA_SIZE, inputData, 0, NULL, NULL);
    
Po paruošimo, sekantis žingsnis yra pačios programos paleidimas

    clEnqueueNDRangeKernel(command_queue, kernel, 1, NULL, &global, NULL, 0, NULL, NULL);
    
ir laukiam, kol branduolys pilnai baigs apdoroti visas komandas eilėje

    clFinish(command_queue);
    
baigus darbui, programos rezultatas yra nuskaitomas

    float results[DATA_SIZE] = {0};
    clEnqueueReadBuffer(command_queue, output, CL_TRUE, 0, sizeof(float)* DATA_SIZE, results, 0, NULL, NULL);
    
ir parodomas komandinėje eilutėje

    printf("output: \n");
    for (i = 0; i < DATA_SIZE; i++) {
        printf("%f \n", results[i]);
    }

### opencl dalis

Pati programos dalis, kuri yra vykdoma grafinėje posistemėje yra labai paprasta.
Argumentai, kurie yra paduodami programos vykdymui yra sudauginami

    output[id] = input[id] * input[id];
    
identifikacinis numeris ``id`` yra gaunamas per globalią funkciją

    size_t id = get_global_id(0);

## Išvados

Laboratorinio darbo metu buvo nustatyta, kad Mac operacinė sistema pagal numatytus nustatymus jau turi įdiegtas OpenCL bibliotekas, todėl jokių papildomų žingsnių atlikti nereikėjo. Taip pat buvo išnagrinėta paprasta programa, kuri tiesiog sudaugina paduodamą argumentą ir gražiną atsakymą. Didesnė dalis programos dalis yra C kalba, kuri atlieka visus reikalingus paruošimo darbus, kurie yra reikalingi OpenCL programos paleidimui.
