package lt.maksinm.two;

import lt.maksinm.one.MutableInteger;

public class RealiujuSudetis implements Runnable
{
    // lokalusis kintamasis ("viršutinė riba")
    private int upper;
    // lokalusis kintamasis ("besikeičianti suma")
    private MutableInteger sumValue;

    // Konstruktorius...
    public RealiujuSudetis(
            int upper,
            MutableInteger sumValue
    ) {

        if (upper < 0) {
            throw new IllegalArgumentException();
        }

        this.upper = upper;
        this.sumValue = sumValue;
    }

    /**
     * Metodas vykdantis sumavimą
     */
    public void run()
    {
        // globalusis kintamasis "sum"
        float sum = 0;

        // Sumavimo ribos kontrolė
        while (sum <= upper) {
            // Sudėties veiksmas
            sum += 0.5;
        }

        /* Objektas "sumValue" kviečia metodą "set" ir perduoda jam reiksmę "sum" */
        sumValue.setValue((int) sum);

    }

}
