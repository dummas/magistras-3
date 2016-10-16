# Paskirstytų sistemų inžinerija

#### OpenMP/Pthreads
#### Laboratorinis darbas 4, AKSfm-15, Maksim Norkin

## Užduotis

Išsiaiškinti kaip veikia OpenMP.

## Hello

Programa yra pradedama nuo kintamųjų deklaravimo

    int nthreads, tid;

Toliau seka ``OpenMP`` funkcija, kuri paskirsto visoms gijoms savas kintamųjų kopijas

    #pragma omp parallel private(nthreads, tid) {

Gauname gijos numerį ir pasisveikinam

    tid = omp_get_thread_num();
    printf("Hello World from thread = %d\n", tid);


Iš pagrindinės programos nurodome kiek iš viso gijų buvo paleista

    nthreads = omp_get_num_threads();
    printf("Number of threads = %d\n", nthreads);

## info

Programa pradedama identiškai, kaip ir prieš tai buvusi -- kintamieji kopijuojami į kiekvieną giją

    #pragma omp parallel private(nthreads, tid) {

Gaunam informaciją apie gijos numerį ir parodome demonstracinę žinutę

    tid = omp_get_thread_num();
    printf("Hello World from thread = %d\n", tid);


Toliau, pagrindinės programos gijoje, surenkame informaciją apie programą

    procs = omp_get_num_procs();
    nthreads = omp_get_num_threads();
    maxt = omp_get_max_threads();
    inpar = omp_in_parallel();
    dynamic = omp_get_dynamic();
    nested = omp_get_nested();

Ir vėliau ją parodome.

## Loop_work-sharing

Programinis kodas pradedamas nuo darbo masyvo aprašymo

    for (i=0; i < N; i++) {
      a[i] = b[i] = i * 1.0;
    }

    chunk = CHUNKSIZE;

Toliau prasideda duomenų dalinimo aprašymas, kurių viena dalis yra privačios kopijos -- ``i``, ``tid``; o likusi dalis bendra

    #pragma omp parallel shared(a,b,c,nthreads,chunk) private(i,tid) {
    
Sekantis žingsnis yra ciklo paskirstymas per gijas. Tai yra atliekama 

    #pragma omp for schedule(dynamic,chunk)
    
Kur ``dynamic`` reiškia ciklo paskirstytą tipą, kuris naudoja vidines darbo eiles pagal ``chunk`` teigiamo kintamojo dydį. Kuomet gija baigia savo darbą, jinai paima naują ciklo gabalą iš darbinės eilės.

## matmul

Kaip ir kitos programos, darbo paskirstymas pradedamas nuo privačių ir globalių kintamųjų aprašymo  

    #pragma omp parallel shared(a,b,c,nthreads,chunk) private(tid,i,j,k) {

Sekantis žingsnis yra paskirstytas matricų inicijavimas per ciklus. Šiuo atveju yra naudojamas statinis ``static`` operatorius, kuris lygiomis dalimis paskirsto ciklo elementus tarp esamų gijų. Tokia operacija yra atliekama su ``a``, ``b`` ir ``c`` matricomis.

    #pragma omp for schedule (static, chunk)
    
Matricos daugyba yra atliekama tokiu pačiu principu.

## reduction

Programa pradedama nuo duomenų inicijavimo

    n = 100;
    for(i=0; i < n; i++) {
        a[i] = b[i] = i * 1.0;
    }
    sum = 0.0;
    
Tolimesnis žingsnis yra redukcijos operacija, kuri yra aprašoma ``for`` ciklu

    for(i=0; i < n; i++) {
        sum = sum + (a[i] * b[i]);
    }

Ir paskirstoma tarp gijų per ``reduction``, kur pirmas operandas yra operacijos išraiška, o antras operandas yra kintamojo padavinimas

    #pragma omp parallel for reduction(+:sum)

## Sections_work-sharing

Programą pradedame nuo duomenų inicijavimo

    for (i=0; i<N; i++) {
        a[i] = i * 1.5;
        b[i] = i + 22.35;
        c[i] = d[i] = 0.0;
    }
    
Paskirstome duomenis tarp gijų

    #pragma omp parallel shared(a,b,c,d,nthreads) private(i,tid)
    
Pradedame darbą su duomenimis inicijuodami kodo vietas, kurios bus paskirstytos tarp visų gijų. Parametras ``nowait`` identifikuoja jokio barjero nebuvimą

    #pragma omp sections nowait

Toliau seka darbo blokai, kurie pradedami

    #pragma omp section
    
Kuri gija pirma pasiekia šitą bloką, jį ir daro. Kitos gijos arba ieško sekančio tokio bloko arba laukia, kol kita gija baigs darbą sekcijoje

## Išvados

Laboratorinio darbo metu buvo išnagrinėta OpenMP bibliotekos įgyvendinti pavyzdžiai. Atlikta analizė programų, su paskirstytais ciklais, darbine atmintimi ir kritiniais blokais.
