package lt.maksinm;

/**
 * Petersons.java
 *
 * This program implements strict alternation as a means of handling synchronization.
 *
 * Note - Using an array for the two flag variables would be preferable, however  we must
 * declare the data as volatile and volatile does not extend to arrays.
 */


public class Petersons implements MutualExclusion
{
    private volatile int turn;
    private volatile boolean flag0;
    private volatile boolean flag1;

    public Petersons()
    {
        flag0 = false;
        flag1 = false;

        turn = 0;
    }

    /**
     * @param t
     */
    public void entrySection(int t)
    {
        System.out.println("entrySection, t: " + t);
        int other = 1 - t;

        // jeigu t == 0
        if (t == 0) {
            // perduodam ejima kitam
            turn = other;
            // kitas yra nulinis elementas
            flag0 = true;
            // laukiam kol pirmas elementas bus sekantis
            while ((flag1) && (turn == other)) {
                Thread.yield();
            }

        } else {

            // duodam sau ejima
            turn = other;
            // pazymime, kad pirmas elementas yra dabartinis
            flag1 = true;
            // laukiam kada bus nulinio elemento eile
            while ((flag0) && (turn == other)) {
                Thread.yield();
            }
        }
    }

    /**
     * @param t
     */
    public void exitSection(int t)
    {
        System.out.println("exitSection, t: " + t);
        if (t == 0) {
            flag0 = false;
        } else {
            flag1 = false;
        }
    }
}