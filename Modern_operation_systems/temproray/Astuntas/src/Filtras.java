
public class Filtras { 
	private float F1;
	private float F2;
	private String FiltroTipas;
	
    public float getF1( )
    {	
        return F1;		
    }
	
    public float getF2()
    {	
        return F2;	
    }
	
	
    public String getFiltroTipas()
    {	
        return FiltroTipas;		
    }
	
    public void setF1(float newF1)
    {	
        F1 = newF1;	
    }
	
    public void setF2(float newF2)
    {	
       F2 = newF2;	
    }
	
    public void setFiltroTipas(String newFiltroTipas)
    {	
        FiltroTipas = newFiltroTipas;
    }//end setPrice()
    
    public float getDazniuJuosta()
    {
    float Ilgis=F2-F1;
    return Ilgis;
    
    }
}//end class



