
public class SukurtiFiltra2 {

	public static void main(String args[]) {
		
		Filtras2 F = new Filtras2();
		
		F.setF1(10000); 
		F.setF2(50000);
		F.setFiltroTipas("BPF");
		
        int F1 =F.getF1();
		
        int F2 = F.getF2();
        
        int Ilgis=F.getDazniuJuosta();
        
        String FiltroTipas = F.getFiltroTipas();
			
		
        System.out.println("F1= " + F1);
		
        System.out.println("F2= " + F2);
		
        System.out.println("Filtro tipas : " + FiltroTipas);
        
        System.out.println("Daþniu diapozonas= " + Ilgis);
		
	}

}
