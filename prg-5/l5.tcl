

set flows 0


set ns [new Simulator]

set tf [open lp5.tr w]
$ns trace-all $tf

set nodes(is) [$ns node]
set nodes(ms) [$ns node]
set nodes(bs1) [$ns node]
set nodes(bs2) [$ns node]
set nodes(lp) [$ns node]


	global ns nodes

	$ns duplex-link $nodes(lp) $nodes(bs1) 3Mbps 10ms DropTail
	$ns duplex-link $nodes(bs1) $nodes(ms) 1 1 RED
	$ns duplex-link $nodes(ms) $nodes(bs2) 1 1 RED
	$ns duplex-link $nodes(bs2) $nodes(is) 3Mbps 50ms DropTail

	puts "GSM Cell Topology"



	global ns nodes bwDL propDL
	
	$ns bandwidth $nodes(bs1) $nodes(ms) 9600 duplex
	$ns bandwidth $nodes(bs2) $nodes(ms) 9600 duplex
	
	$ns delay $nodes(bs1) $nodes(ms) 0.500 duplex
	$ns delay $nodes(bs2) $nodes(ms) 0.500 duplex
	
	$ns queue-limit $nodes(bs1) $nodes(ms) 10
	$ns queue-limit $nodes(bs2) $nodes(ms) 10


Queue/RED set adaptive_ 1
Queue/RED set thresh_ 30
Queue/RED set maxthresh_ 0
Agent/TCP set widow_ 30



$ns insert-delayer $nodes(ms) $nodes(bs1) [new Delayer]
$ns insert-delayer $nodes(ms) $nodes(bs2) [new Delayer]

if {$flows == 0} {
set tcp [new Agent/TCP]
$ns attach-agent $nodes(is) $tcp
set ftp [new Application/FTP]
$ftp attach-agent $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $nodes(lp) $sink
$ns connect $sink $tcp
$ns at 0.8 "$ftp start"
}

proc stop {} {
	global nodes opt tf
	
	set wrap 100
	
	set sid [$nodes(is) id]
	set did [$nodes(bs2) id]
	
	set a "lp5.tr"
	
	set GETRC "../getrc.tcl"
	set RAW2XG "../raw2xg.tcl"

	exec $GETRC -s $sid -d $did -f 0 lp5.tr | \
	$RAW2XG -s 0.01 -m $wrap -r > plot.xgr
	
	exec $GETRC -s $did -d $sid -f 0 lp5.tr | \
	$RAW2XG -o -a -s 0.01 -m $wrap >> plot.xgr
	
	exec xgraph plot.xgr &
	
	exit 0
}

$ns at 100 "stop"
$ns run
