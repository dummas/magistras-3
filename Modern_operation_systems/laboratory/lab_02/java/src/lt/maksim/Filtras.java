package lt.maksim;

import lt.maksim.FiltrasType;

/**
 * Created by maksimnorkin on 21/02/16.
 */
public class Filtras
{

    private float f1;

    private float f2;

    private FiltrasType type;

    public Filtras(float f1, float f2, FiltrasType type) {
        this.f1 = f1;
        this.f2 = f2;
        this.type = type;
    }

    public float getF1() {
        return f1;
    }

    public float getF2() {
        return f2;
    }

    public FiltrasType getType() {
        return type;
    }
}
