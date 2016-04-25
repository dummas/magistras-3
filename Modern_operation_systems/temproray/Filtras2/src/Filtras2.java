
public class Filtras2 {
	
	int F1;
	int F2;
    String FiltroTipas;

	
    public int getF1()
    {
	
        return F1;
		
    }
	
    public int getF2()
    {
	
        return F2;
	
    }
	
	
    public String getFiltroTipas()
    {
	
        return FiltroTipas;	
	
    }
	
    public void setF1(int newF1)
    {
	
        F1 = newF1;
	
    }
	
    public void setF2(int newF2)
    {
	
       F2 = newF2;
	
    }
	
    public void setFiltroTipas(String newFiltroTipas)
    {
	
        FiltroTipas = newFiltroTipas;

    }//end setPrice()
    
    public int getDazniuJuosta()
    {
    int Ilgis=F2-F1;
    return Ilgis;
    
    }
}//end class



