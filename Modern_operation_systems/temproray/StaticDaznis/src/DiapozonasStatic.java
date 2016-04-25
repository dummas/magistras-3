
public class DiapozonasStatic {

	public static void main(String[] args) {
		Dazniai Da = new Dazniai();
		long ats= Long.parseLong(args[0]);
		String Atsakymas= Da.DazniuJuosta(ats);
		System.out.println("Daþnis " + Atsakymas);
		
	}

}
