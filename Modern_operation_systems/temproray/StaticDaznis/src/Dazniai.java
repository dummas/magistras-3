
public class Dazniai {
	
	public static String DazniuJuosta (long  DaznioSkaicius)
	{
		
		if (DaznioSkaicius<30000)
		{
			return "labai þemi";
		}
		else if (DaznioSkaicius<300000)
		{
			return "þemieji";
		}
		else if (DaznioSkaicius<3000000)
		{
			return "vidutiniai";
		}
		else if (DaznioSkaicius<30000000)
		{
			return "aukðtieji";
		}
		else if (DaznioSkaicius<300000000)
		{
			return "ultra aukðtieji";
		}
		else if (DaznioSkaicius<3000000000L)
		{
			return "superaukðtieji";
		}
		else if (DaznioSkaicius<30000000000L)
		{
			return "ypaè aukðti";
		}
		else if (DaznioSkaicius<300000000000L)
		{
			return "hiperaukðtieji";
		}
		
		else{
		return null;}
	}

}
