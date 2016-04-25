package lt.maksinm.one;

import lt.maksinm.two.RealiujuSudetis;


public class Valldyklis {

    public static void main(String[] args)
    {
        if (args.length != 1) 	/* Tikrinama, ar paleidžiant programą nurodyta sumavimo riba */
        {
            System.err.println("Usage Driver <integer>");
            /* Jei nenurodyta sumavimo riba, rodomas pranešimas apie klaidą */

            // Nutraukiamas programos vykdymas
            System.exit(0);
        }

        /* Sukuriamas naujas objektas, priklausantis klasei „MutableInteger sumObject“ */
        MutableInteger sumObject = new MutableInteger();

        /* Iš komandinės eilutės suvedama sumavimo riba „upper“ */
        int upper = Integer.parseInt(args[0]);

        /* Sukuriama nauja gija „worker“ priklausanti klasei „Thread“ */
        Thread darbininkas2 = new Thread(new RealiujuSudetis(upper, sumObject));

        // Gija „worker“ suaktyvinama
        darbininkas2.start();

        // Gijos vykdymas kontroliuojant galimas klaidas
        try
        {
            // Gija „worker“ laukia kol bus baigtas sumavimas
            darbininkas2.join();
        } catch (InterruptedException ie) {
            // Klaidų fiksavimas
        }

        System.out.println("The value of " + upper + " is " + sumObject.getValue());
    }

}
