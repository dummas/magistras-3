
public class Dazniai {
	
	public static String DazniuJuosta (long  DaznioSkaicius)
	{
		
		if (DaznioSkaicius<30000)
		{
			return "labai �emi";
		}
		else if (DaznioSkaicius<300000)
		{
			return "�emieji";
		}
		else if (DaznioSkaicius<3000000)
		{
			return "vidutiniai";
		}
		else if (DaznioSkaicius<30000000)
		{
			return "auk�tieji";
		}
		else if (DaznioSkaicius<300000000)
		{
			return "ultra auk�tieji";
		}
		else if (DaznioSkaicius<3000000000L)
		{
			return "superauk�tieji";
		}
		else if (DaznioSkaicius<30000000000L)
		{
			return "ypa� auk�ti";
		}
		else if (DaznioSkaicius<300000000000L)
		{
			return "hiperauk�tieji";
		}
		
		else{
		return null;}
	}

}
