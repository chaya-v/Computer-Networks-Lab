import java.util.Scanner;
public class bucket {
public static void main(String[] args)
{
Scanner sc=new Scanner(System.in);
int bucket=0;
int op_rate,i,n,bsize;
System.out.println("Enter the number of packets");
n=sc.nextInt();
System.out.println("Enter the output rate of the bucket");
op_rate=sc.nextInt();
System.out.println("Enter the bucket size");
bsize=sc.nextInt();
System.out.println("Enter the arriving packets(size)");
int pkt[]=new int[n];
for(i=0;i<n;i++)
{
pkt[i]=sc.nextInt();
}
System.out.println("\nSec\tpsize\tBucket\tAccept/Reject\tpkt_send");
System.out.println("----------------------------------------------------");
for(i=0;i<n;i++)
{
System.out.print(i+1+"\t"+pkt[i]+"\t");
if(bucket+pkt[i]<=bsize)
{
bucket+=pkt[i];
System.out.print(bucket+"\tAccept\t\t"+min(bucket,op_rate)+"\n");
bucket=sub(bucket,op_rate);
}
else
{
int reject=(bucket+pkt[i]-bsize);
bucket=bsize;
System.out.print(bucket+"\tReject "+reject+"\t"+min(bucket,op_rate)+"\n");
bucket=sub(bucket,op_rate);
}
}
while(bucket!=0)
{
	System.out.print((++i)+"\t0\t"+bucket+"\tAccept\t\t"+min(bucket,op_rate));
bucket=sub(bucket,op_rate);
}
}
static int min(int a,int b)
{
return ((a<b)?a:b);
}
static int sub(int a,int b)
{
return (a-b)>0?(a-b):0;
}
}