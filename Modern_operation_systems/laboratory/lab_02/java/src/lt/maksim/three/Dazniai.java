package lt.maksim.three;

import java.util.Scanner;

/**
 * Created by maksimnorkin on 22/02/16.
 */
public class Dazniai {

    public static void main(String args[]) {
        float daznis;
        DazniaiType dazniaiType;

        Scanner scanner = new Scanner(System.in);

        System.out.print("Daznis: ");
        // nuskaitome dazni
        String rawDaznis = scanner.next();

        try {
            // konvertuojame verte i float tipo
            daznis = Float.valueOf(rawDaznis);
        } catch (NumberFormatException e) {
            System.out.println("Daznis " + rawDaznis + " neatrodo kaip daznis");

            return;
        }

        System.out.println("daznis: " + daznis);

        // randame diapazona
        dazniaiType = DiapazonasStatic.diapazonas(daznis);

        System.out.println("Dazniai diapazonas, pagal tipa: " + dazniaiType);
    }
}
