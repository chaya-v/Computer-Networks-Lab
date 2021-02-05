BEGIN{
	PktsSent=0;
	PktsRcvd=0;
	PktsAtRTR=0;
}
{
	if(($1=="s")&&($4=="RTR")&&($7=="tcp")) PktsAtRTR++;
	if(($1=="s")&&($4=="AGT")&&($7=="tcp")) PktsSent++;
	if(($1=="r")&&($4=="AGT")&&($7=="tcp")) PktsRcvd++;
}
END{
	print " Number of Packets Sent :" PktsSent
	print " Number of Packets Received :" PktsRcvd
	print " Packet Delivery Ratio :" PktsRcvd/PktsSent*100
	print " Routing Load :" PktsAtRTR/PktsRcvd
}
