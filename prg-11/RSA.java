import java.util.*;
import java.math.*;
public class RSA
{
    static BigInteger p,q,e,d,n,phi;
    static int bitLength=256;
    static Scanner S=new Scanner(System.in);
    static Random R=new Random();
    public static void main (String args[])
    {   p=BigInteger.probablePrime(bitLength,R);
        q=BigInteger.probablePrime(bitLength,R);
        n=p.multiply(q);
        e=BigInteger.probablePrime(bitLength/2,R);
        phi=p.subtract(BigInteger.ONE).multiply(q.subtract(BigInteger.ONE));
        while(phi.gcd(e).compareTo(BigInteger.ONE)!=0 && e.compareTo(phi)<0)
        e.add(BigInteger.ONE);
        d=e.modInverse(phi);
        String msg="";
        System.out.print("Enter The Msg : ");
        msg=S.nextLine();
        byte msg_arr[]=msg.getBytes();
        System.out.println("Msg Byte Array : "+display(msg_arr));
        byte en[]=encrypt(msg_arr);
        System.out.println("Encrypted Byte Array : "+display(en));
        byte de[]=decrypt(en);
        System.out.println("Decrypted Byte Array : "+display(de));
        System.out.println("Received Msg : "+ new String(de));
    }
    static byte[] encrypt(byte a[])
    { return (new BigInteger(a).modPow(e,n)).toByteArray(); }
    static byte[] decrypt(byte a[])
    { return (new BigInteger(a).modPow(d,n)).toByteArray(); }
    static String display(byte a[])
        {String s="";
        for(int i=0;i<a.length;i++)
        s+=Byte.toString(a[i]);
        return s;}
 }