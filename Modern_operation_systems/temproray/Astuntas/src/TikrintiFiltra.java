
public class TikrintiFiltra {

	public static void main(String[] args) {
		
		Filtras F = new Filtras();
		float Pirmas = Float.parseFloat(args[0]);
		float Antras = Float.parseFloat(args[1]);
		String Trecias = args[2];

		F.setF1(Pirmas);
		F.setF2(Antras);
		F.setFiltroTipas(Trecias);
		
		float F1 = F.getF1();
        float F2 = F.getF2();
        
        float Ilgis=F.getDazniuJuosta();
        
        String FiltroTipas = F.getFiltroTipas();
		
        if (F.getF1()<F.getF2())
        {
        	float DazniuJuosta =F.getF2()-F.getF1();
        	 System.out.println("Daþniu diapozonas= " + DazniuJuosta);
        	 System.out.println("Filtro tipas= " + FiltroTipas);
        }
        	 else
        	 {
        		 System.out.println("Daþniu diapozonas neskaièiuojamas");
        	 }
        
		
	}

}
