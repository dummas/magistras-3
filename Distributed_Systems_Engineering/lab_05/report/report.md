# Paskirstytų sistemų inžinerija

#### CUDA/OpenCL
#### Laboratorinis darbas 5, AKSfm-15, Maksim Norkin

## Užduotis

Susidiegti OpenCL ant ubuntu platformos.

## Darbo eiga

Darbui palengvinti buvo panaudotas ``Vagrant`` programinis paketas.

Darbas pradedamas nuo virtualios mašinos inicijavimo.

    vagrant init minimal/trusty64

Atlikus sistemos inicializavimą, atnaujinam paketų tvarkyklę

    apt-get update

Ir sudiegiam ``opencl`` bibliotekas

    apt-get install -y ocl-icd-opencl-dev

## Išvados

Laboratorinio darbu metu buvo sudiegtos OpenCL bibliotekos ant ubuntu platformos.
