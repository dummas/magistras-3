package lt.maksim.two;

import lt.maksim.Filtras;
import lt.maksim.FiltrasType;

import java.io.Console;
import java.util.Scanner;
import java.util.logging.Filter;

/**
 * Created by maksimnorkin on 21/02/16.
 */
public class TikrintiFiltras
{


    public static void main(String[] args)
    {

        // pirmas daznis
        float f1;
        // antras daznis
        float f2;

        Scanner scanner = new Scanner(System.in);

        System.out.print("f1: ");
        // nuskaitome pirma dazni
        String rawF1 = scanner.next();

        System.out.print("f2: ");
        // nuskaitome antra dazni
        String rawF2 = scanner.next();

        try {
            f1 = Float.valueOf(rawF1);
        } catch (NumberFormatException e) {
            System.out.println("f1 " + rawF1 +  " nera skaicius");

            return;
        }

        try {
            f2 = Float.valueOf(rawF2);
        } catch (NumberFormatException e) {
            System.out.println("f2 " + rawF2 +  " nera skaicius");

            return;
        }

        // sukuriame filtra
        Filtras filtras = new Filtras(f1, f2, FiltrasType.LOW_PASS);

        // pardome reiksmes
        System.out.println("f1: " + filtras.getF1());
        System.out.println("f2: " + filtras.getF2());

        // tikriname ar galime apskaiciuoti ribas
        if (filtras.getF1() < filtras.getF2()) {
            float dazniuJuosta = filtras.getF2() - filtras.getF1();

            System.out.println("Dazniu juosta: " + dazniuJuosta);
        } else {
            System.out.println("Dazniu juosta neskaiciuojama");
        }

    }
}
