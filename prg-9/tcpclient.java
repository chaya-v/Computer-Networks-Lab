import java.util.*;
import java.net.*;
import java.io.*;
public class tcpclient
{
    public static void main(String args[])
    {
        try
        {
            Scanner ser=new Scanner(System.in);
            Socket s=new Socket("localhost",998);
            DataInputStream dis=new DataInputStream(s.getInputStream());
            DataOutputStream dos=new DataOutputStream (s.getOutputStream());
            dos.writeUTF("connected to 127.0.0.1 \n");
            System.out.println(dis.readUTF());
            System.out.println("\n enter the full path of the the file to be displayed");
            String path=ser.nextLine();
            dos.writeUTF(path);
            System.out.println(new String (dis.readUTF()));
            dis.close();
            dos.close();
            s.close();
            ser.close();
        }
        catch(IOException e)
        {
            System.out.println("IO: "+e.getMessage());
        }
    }
}