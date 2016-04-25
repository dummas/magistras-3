package lt.maksim.three;

/**
 * Created by maksimnorkin on 22/02/16.
 */
public class DiapazonasStatic {

    public static DazniaiType diapazonas(float daznis)
    {
        DazniaiType dazniaiType = null;

        if (daznis > 3e3 & daznis <= 30e3) {
            dazniaiType = DazniaiType.LABAI_ZEMI;
        }
        if (daznis > 30e3 && daznis <= 300e3) {
            dazniaiType = DazniaiType.ZEMIEJI;
        }

        if (daznis > 0.3e6 && daznis <= 3e6) {
            dazniaiType = DazniaiType.VIDUTINIAI;
        }

        if (daznis > 3e6 && daznis <= 30e6) {
            dazniaiType = DazniaiType.AUKSTIEJI;
        }

        if (daznis > 30e6 && daznis <= 300e6) {
            dazniaiType = DazniaiType.LABAI_AUKSTI;
        }

        if (daznis > 0.3e9 && daznis <= 3e9) {
            dazniaiType = DazniaiType.ULTRAAUKSTIEJI;
        }

        if (daznis > 3e9 && daznis <= 30e9) {
            dazniaiType = DazniaiType.SUPERAUKSTIEJI;
        }

        if (daznis > 30e9 && daznis <= 300e9) {
            dazniaiType = DazniaiType.YPAC_AUKSTI;
        }

        if (daznis > 300e9 && daznis <= 3000e9) {
            dazniaiType = DazniaiType.HIPERAUKSTIEJI;
        }

        return dazniaiType;
    }
}
