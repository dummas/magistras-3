public class CreateShirt
{
    public static void main(String args[])
    {
	
        Shirt newShirt = new Shirt();
		
        float shirtPrice = newShirt.getPrice();
		
        int shirtID = newShirt.getItemID();
	
        String shirtType = newShirt.getShirtType();
			
        // ..and now print out the values found....
		
        System.out.println("The price of the shirt is " + shirtPrice);
		
        System.out.println("The shirt ID is " + shirtID);
		
        System.out.println("The type of the shirt is " + shirtType);
		
    }// end main

}//end class