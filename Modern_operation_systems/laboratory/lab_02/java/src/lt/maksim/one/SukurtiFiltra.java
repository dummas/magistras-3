package lt.maksim.one;

import lt.maksim.Filtras;
import lt.maksim.FiltrasType;

/**
 * Created by maksimnorkin on 21/02/16.
 */
public class SukurtiFiltra {

    public static void main(String[] args)
    {
        // Sukuriame filtra
        Filtras filtras = new Filtras(10, 100, FiltrasType.LOW_PASS);

        System.out.println("Filter f1: " + filtras.getF1());

        System.out.println("Filter f2: " + filtras.getF2());

        // apskaiciuojame dazniu juosta
        float dazniuJuosta = filtras.getF2() - filtras.getF1();

        System.out.println("Dazniu juosta: " + dazniuJuosta);

        System.out.println("Filter type: " + filtras.getType());

    }
}
