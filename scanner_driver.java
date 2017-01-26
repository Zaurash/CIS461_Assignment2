import java.io.*;

public class scanner_driver{
	
	public static void main(String args[]){
		try{
			Process process2 = Runtime.getRuntime().exec("java lex_scanner " + args[0]);
			
		    InputStream inputStream = process2.getInputStream();
			InputStream errorStream = process2.getErrorStream();
		    int x,y = -1;
		    while ((x = inputStream.read()) != -1){
		        System.out.write(x);
		    }
			while ((y = errorStream.read()) != -1){
				System.out.write(y);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
}