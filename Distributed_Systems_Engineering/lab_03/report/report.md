# Paskirstytų sistemų inžinerija

#### JAVA RMI
#### Laboratorinis darbas 3, AKSfm-15, Maksim Norkin

## Užduotis

Išnagrinėti kaip veikia Java RMI protokolas

## Serveris

Serverio programa pradedama nuo ``Hello`` funkcijos parašymo. RMI atsakys į ``Hello`` funkciją ``Hello`` objektu

    Naming.rebind("Hello", new Hello ("Hello,From PSI!"));
    
Pats objektas atrodo taip

    public class Hello extends UnicastRemoteObject implements HelloInterface
    {
        private String message;

        public Hello (String msg) throws RemoteException
        {
            message = msg;
        }

        public String say() throws RemoteException
        {
            return message;
        }
    }

Kur ``HelloInterface`` yra paprasta sąsaja su ``Remote`` objektu

    public interface HelloInterface extends Remote
    {
        public String say() throws RemoteException;
    }

Tuom serverio dalis ir baigiasi

## Klientas

Klientas pradedamas nuo objekto paieškos serverio pusėje, kuri įgyvendinta ``HelloInterface`` sąsaja

    HelloInterface hello =(HelloInterface) Naming.lookup ("//localhost/Hello");
    
Tolimesnis žingsnis yra darbas su nuotoliniu objektu, šiuo atveju paprasto rezultato išvedimas į kosnolę

    System.out.println (hello.say());
    
## Išvados

Laboratorinio darbo metu buvo išnagrinėta Java RMI implementacija. Aprašyta serverio ir kliento pusė. Detaliai pateiktas nuotolinis objektas.
