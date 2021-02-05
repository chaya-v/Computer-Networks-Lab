import java.net.*;
import java.io.*;
public class UDPClient
{
public static void main(String args[])
{
DatagramSocket aSocket=null;
int clientPort=998;
try
{
aSocket=new DatagramSocket(clientPort);
byte[] buf=new byte[1000];
DatagramPacket data=new DatagramPacket(buf,buf.length);
System.out.println("Waiting for server\n");
aSocket.receive(data);
byte[] msg=new byte[1000];
msg=data.getData();
System.out.println("\n msg:"+(new String(msg,0,data.getLength())));
}
catch(SocketException e)
{
System.out.println("Socket:" + e.getMessage());
}
catch(IOException e)
{
    System.out.println("IO:" + e.getMessage());
}
finally
{

if(aSocket!=null)
    aSocket.close();
}
}
}