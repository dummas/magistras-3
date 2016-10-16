# Paskirstytų sistemų inžinerija

#### Paskirstyti skaičiavimai su MPI
#### Laboratorinis darbas 1, AKSfm-15, Maksim Norkin

## Užduotis

Apibūdinti programos, kuri naudoja MPI biblioteka, atliekamus veiksmus.

## hello

Programos pradžioje, visi ateinantys argumentai iš komandinės eilutės yra perduodami į ``MPI`` inicializavimą, funkcijos tikslas yra paruošti ``MPI`` paleidimo aplinką.

    MPI_Init(&argc, &argv);

Toliau yra perduodamas asocijuojamos grupės dydžio parametras komunikatoriui

    MPI_Comm_size(MPI_COMM_WORLD, &size);

Toliau seka proceso rango dydžio parametras komunikatoriui

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

Apibrėžiam proceso pavadinimą,

    MPI_Get_processor_name(processor_name, &namelen);

Išvedame surinktus parametrus iš MPI ir išvedame juos į ekraną

    printf("Procesas %d kompiuteryje %s is %d\n", rank, processor_name, size);

Darbo pabaigoje užbaigiame komunikaciją su ``MPI``

    MPI_Finalize();


## sendrecv

Sekanti programa prasideda nuo status kintamojo aprašymo

    MPI_Status status;

Toliau inicializuojam ``MPI`` pasaulį

    MPI_Init(&argc, &argv);

Ir nusakome proceso rangą, kaip ir ``hello`` pavyzdyje

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

Toliau seka programos eigos skaidymas. Yra tikrinama kuris programos rangas yra. Jeigu proceso rangas yra nulis, tuomet yra siunčiami duomenis į pirmo rango programą

    if ( rank == 0 )
    {
        MPI_Send(&A, 1, MPI_INT, 1, tag, MPI_COMM_WORLD);
        printf("Procesas %d : siuncia duomenis %d\n", rank, A);
    }

Jeigu proceso rangas yra pirmas, tuomet programa klauso ateinančių paketų iš pirmo rango proceso

    else if ( rank == 1 )
    {
        MPI_Recv(&A, 1, MPI_INT, 0, tag, MPI_COMM_WORLD, &status);
        printf("Procesas %d : priima duomenis %d\n", rank, A);
    }

Galiausiai, programos darbą užbaigiam

    MPI_Finalize();

## sendrecvarray

Programa labai panaši į prieš tai buvusią. Skirtumas yra tas, kad šiuo atveju tarp programų su skirtingais rangais yra perduodamas ne vienas skaičius, o simbolių masyvas. Keičiasi duomenų siuntimo tipas

    MPI_Send(&message, 12, MPI_CHAR, 1, tag, MPI_COMM_WORLD);

Vietoj ``MPI_INT`` dabar duomenų tipas yra ``MPI_CHAR``.

## isendirecv

Ši programa demonstruoja kaip dirbti su ``MPI_Isend``. Tai yra metodas, kuris neblokuotai persiunčia žinutės tekstą iš vienos gijos į kitą giją.

Pirmiausiai deklaruojam užklausos būseną ir statusą

    MPI_Status status;
    MPI_Request request;

Išsiunčiam žinutę ir nelaukiam kada žinutę priims gavėjas

    MPI_Isend(&A,1,MPI_INT,1,tag,MPI_COMM_WORLD,&request);

Kito rango programoje asinchroniškai priimam žinutę

    MPI_Irecv(&A,1,MPI_INT,0,tag,MPI_COMM_WORLD,&request);

Toliau yra laukiama, kuomet abiejų rangų programos apsikeis duomenimis

    MPI_Wait(&request,&status);

Tokia operacija yra naudinga, norint būti užtikrintiems ar priimančioji pusė sėkmingai priėmė žinutę.

## deadlock

Pradžioje rezervuojame atminties sritį

    int *i = malloc(sizeof(int) * BIG);

Priskiriam pirmą atminties vietą kaip programos rangą

    i[0] = rank;

O paskutiniam elementui priskiriam elementų skaičių padauginę iš rango

    i[BIG - 1] = size * (rank + 1);

Toliau aprašomas kreipinys

    MPI_Request req;

Ir asinchroniškai siunčiam žinutę

    MPI_Isend(i, BIG, MPI_INT, (rank + 1) % size, 1, MPI_COMM_WORLD, &req);

kur ``i`` siunčiamas buferis, ``BIG`` yra siunčiamų duomenų dydis, ``MPI_INT`` duomenų tipas, ``(rank + 1) % size`` adresatas.

Atliekama laukimo operacija, kol baigsis mpi užklausa.

    MPI_Wait(&req, MPI_STATUS_IGNORE);

Sekantis žingsnis yra žinutės priėmimas

    MPI_Recv(i, BIG, MPI_INT, (rank - 1) % size, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);


kur ``i`` yra primamas buferis, ``BIG`` yra buferio dydis ir kiti, jau aptarti, parametrai.

Paskutinis žingsnis yra uždaryti MPI aplinką

    MPI_Finalize();


## array

Pirmiausiai programa save identifikuoja kaip pagrindinį operuojantį vienetą, kuris skirsto užduotis kitoms gijoms

    if (taskid == MASTER)

Ir inicijuoja masyvą, kuris bus perduodamas gabalais sekančioms gijoms

    for (i=0; i<ARRAYSIZE; i++) {
        data[i] =  0.0;
    }
    index = 0;

Tolimesnis žingsnis yra išsiųsi informaciją, nuo kur kiekvienam iš procesų pradėti analizuoti duomenų masyvą

    MPI_Send(&index, 1, MPI_INT, dest, indexmsg, MPI_COMM_WORLD);

Siunčiam duomenų dalį kiekvienam iš procesų

    MPI_Send(&data[index], chunksize, MPI_FLOAT, dest, arraymsg, MPI_COMM_WORLD);

Išsiuntę duomenis kiekvienam iš procesų, pradedam jų laukti. Pirmiausiai iš šalutinės gijos gauname indeksą duomenų, kuriuos jisai analizavo

    MPI_Recv(&index, 1, MPI_INT, source, indexmsg, MPI_COMM_WORLD, &status);

Tolimesnis žingsnis yra priimti duomenų segmentą

    MPI_Recv(&result[index], chunksize, MPI_FLOAT, source, arraymsg, MPI_COMM_WORLD, &status);

Toliau seka programos kodas, kurį atlieka šalutinė programa. Šalutinė programa pirma gauna indekso vertę

    MPI_Recv(&index, 1, MPI_INT, source, indexmsg, MPI_COMM_WORLD, &status);

Toliau gauna analizuojamų duomenų fragmentą

    MPI_Recv(&result[index], chunksize, MPI_FLOAT, source, arraymsg, MPI_COMM_WORLD, &status);

Atlieka paprastą manipuliacija su duomenimis

    for (i=index; i < index + chunksize; i++) {
        result[i] = i + 1;
    }

Atlikę visus veiksmus, pirmiausiai išsiunčiam indekso informaciją

    MPI_Send(&index, 1, MPI_INT, dest, indexmsg, MPI_COMM_WORLD);

Ir galiausiai pačius duomenis

    MPI_Send(&result[index], chunksize, MPI_FLOAT, MASTER, arraymsg, MPI_COMM_WORLD);

## collectives

Pradžioje yra blokuojami visi komunikacijos procesai, kol yra pasiekiama nurodyta paprogramė.

    MPI_Barrier(MPI_COMM_WORLD);

Sekantis žingsnis yra ``x`` ir ``y`` masyvų užpildymas tarpo simboliu. Masyvų dydis yra procesų skaičiaus dydis

    for (i=0; i<p; i++) {
        x[i] = ' ';
    }

    for (i=0; i<p; i++) {
        y[i] = ' ';
    }

Inicijuojam pradinius duomenis

    alphabet = 'a';  
    x[0] = alphabet+Iam;

kur ``Iam`` yra procesoriaus identifikavimo numeris. Sekantis žingsnis yra duomenų surinkimas iš grupės procesorių:

    MPI_Gather(x,1,MPI_CHAR,  /* send buf,count,type */
             y,1,MPI_CHAR,    /* recv buf,count,type */
             root,            /* root (data origin)  */
             MPI_COMM_WORLD); /* comm,flag           */

Toliau atliekama blokavimo operacija, kol nebus surinkti visu grupės procesų duomenys

    MPI_Barrier(MPI_COMM_WORLD);

Tuomet vėl iš naujo inicijuojam duomenis

    for (i=0; i<p; i++) {
        x[i] = alphabet+i+Iam*p;
        y[i] = ' ';
    }

Ir atliekam duomenų paskirstymo operaciją iš vieno proceso į kitus procesus, kurie yra komunikacijoje

    MPI_Scatter(x,1,MPI_CHAR,  /* send buf,count,type */
              y,1,MPI_CHAR,    /* recv buf,count,type */
              root,            /*    ! data origin    */
              MPI_COMM_WORLD); /* comm,flag           */

Kaip ir kitas operacijas, šitą irgi užbaigiam blokavimu

    MPI_Barrier(MPI_COMM_WORLD);

Vėl per naujo inicijuojam duomenis

    for (i=0; i<p;i++) {
        x[i] = alphabet+i+Iam*p;
        y[i] = ' ';
    }

Ir siunčiam duomenis iš visų procesų į visus procesus

    MPI_Alltoall(x,1,MPI_CHAR,  /* send buf,count,type */
               y,1,MPI_CHAR,    /* recv buf,count,type */
               MPI_COMM_WORLD); /* comm,flag           */

Paskutinė kodo operacija yra žinutės siuntimas iš pagrindinio proceso į kitus procesus, kurie yra komunikacijoje

    MPI_Bcast(&a,1,MPI_CHAR,      /* buf,count,type */
            root,MPI_COMM_WORLD); /* root,comm,flag */

## matmul

Pradžioje inicijuojam matricas

    for (i=0; i<NRA; i++) {
        for (j=0; j<NCA; j++) {
            a[i][j]= i+j;
        }
    }

    for (i=0; i<NCA; i++) {
        for (j=0; j<NCB; j++) {
            b[i][j]= i*j;
        }
    }

Toliau matricos yra skirstomos per darbininkus. Pradžioje yra nurodomas pradinis taškas ir eilutės

    MPI_Send(&offset, 1, MPI_INT, dest, mtype, MPI_COMM_WORLD);
    MPI_Send(&rows, 1, MPI_INT, dest, mtype, MPI_COMM_WORLD);

Po šito, siunčiamos pačios matricos

    MPI_Send(&a[offset][0], rows*NCA, MPI_DOUBLE, dest, mtype, MPI_COMM_WORLD);
    MPI_Send(&b, NCA*NCB, MPI_DOUBLE, dest, mtype, MPI_COMM_WORLD);

ir paskaičiuojamas sekantis nuokrypis        

    offset = offset + rows;

Sekantis žingsnis yra duomenų priėmimas iš paprogramių, pradedant nuo nuokrypio ir eilučių skaičiaus

    MPI_Recv(&offset, 1, MPI_INT, source, mtype, MPI_COMM_WORLD, &status);
    MPI_Recv(&rows, 1, MPI_INT, source, mtype, MPI_COMM_WORLD, &status);

O toliau priimti patį rezultatą

    MPI_Recv(&c[offset][0], rows*NCB, MPI_DOUBLE, source, mtype, MPI_COMM_WORLD, &status);

Dukteriniai procesai pirmiausiai priima duomenis -- nuokrypį ir eilučių skaičių

    MPI_Recv(&offset, 1, MPI_INT, MASTER, mtype, MPI_COMM_WORLD, &status);
    MPI_Recv(&rows, 1, MPI_INT, MASTER, mtype, MPI_COMM_WORLD, &status);

Toliau seka duomenys -- ``a`` ir ``b`` matricos

    MPI_Recv(&a, rows*NCA, MPI_DOUBLE, MASTER, mtype, MPI_COMM_WORLD, &status);
    MPI_Recv(&b, NCA*NCB, MPI_DOUBLE, MASTER, mtype, MPI_COMM_WORLD, &status);

Su gautais duomenimis atliekame skaičiavimus

    for (k=0; k<NCB; k++) {
        for (i=0; i<rows; i++) {
            c[i][k] = 0.0;
            for (j=0; j<NCA; j++) {
                c[i][k] = c[i][k] + a[i][j] * b[j][k];
            }
        }
    }

Siunčiam pagrindiniam procesui savo nuokrypį ir eilučių numerius

    MPI_Send(&offset, 1, MPI_INT, MASTER, mtype, MPI_COMM_WORLD);
    MPI_Send(&rows, 1, MPI_INT, MASTER, mtype, MPI_COMM_WORLD);

Galiausiai persiunčiam rezultatą

    MPI_Send(&c, rows*NCB, MPI_DOUBLE, MASTER, mtype, MPI_COMM_WORLD);


## pical

Pirmiausiai pagrindinė programa nustato programos pradžios laiką

    startwtime = MPI_Wtime();

Toliau yra skleidžiama žinutė visoms žemesnio rango programoms

    MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);

Toliau yra pradedami atlikit skaičiavimai. Pasirenkamas žingsnio dydis, sumos kintamasis

    h = 1.0 / (double) n;
    sum = 0.0;

Pradedamas sumos skaičiavimas, nuo procesoriaus numerio iki ```1000```, atliekant žingsnį per procesorių skaičių

    for (i = myid + 1; i <= n; i += numprocs) {
        x = h * ((double)i - 0.5);
        sum += f(x);
    }
    mypi = h * sum;

Pati funkcija atrodo sekančiu pavidalu

    double f(double a)
    {
        return (4.0 / (1.0 + a*a));
    }

Gauta suma yra siunčiama verčių mažinimo operacijai iš visų procesų į vieną vertę

    MPI_Reduce(&mypi, &pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

Paskutinė operacija yra rezultato klaidos parodymas ir laiko informacija

    printf("pi is approximately %.16f, Error is %.16f\n", pi, fabs(pi - PI25DT));
    endwtime = MPI_Wtime();
    printf("wall clock time = %f\n", endwtime - startwtime);


## Išvados

Laboratorinio darbo metu buvo išnagrinėtos C programavimo kalba parašytos programos, kurios įgyvendina ``MPI`` protokolo implementacijos ``MPICH`` bibliotekos funckijas. ``MPI`` protokolas leidžia labai lengvai atlikinėti lygiagrečias operacijas, įgyvendinti komunikacija tarp procesų.
