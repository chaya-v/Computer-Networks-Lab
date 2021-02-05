import java.util.*;
import java.net.*;
import java.io.*;
public class tcpserver
{
    public static void main (String args[])
    {
        try
        {
            ServerSocket s=new ServerSocket(998);
            System.out.println("server ready \n waiting for connection \n");
            Socket s1=s.accept();
            DataOutputStream dos=new DataOutputStream(s1.getOutputStream());
            DataInputStream dis=new DataInputStream(s1.getInputStream());
            System.out.println(dis.readUTF());
            dos.writeUTF("connected to server \n");
            String path=dis.readUTF();
            System.out.println("\n request received \n processing.......");
            try
            {
                File myfile=new File(path);
                Scanner scr=new Scanner(myfile);
                String st=scr.nextLine();
                st="\n the context of file is \n "+st;
                while(scr.hasNextLine())
                {
                st=st + "\n" + scr.nextLine();
                }
                dos.writeUTF(st);
                dos.close();
                s1.close();
                scr.close();
                }
            catch(FileNotFoundException e)
            {
                System.out.println("\n,,,error...\n file not found");
                dos.writeUTF("...error \n file not found");
            }
        }
        catch(IOException e)
        {
            System.out.println("IO: "+e.getMessage());
        }
        finally
        {
            System.out.println("\n connection terminated");
        }
    }
}