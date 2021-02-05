#create Simulator class
set ns [new Simulator]
#open trace file
set nt [open lab42.tr w]
$ns trace-all $nt
#create Topography object
set topo [new Topography]
#define grid size
$topo load_flatgrid 1000 1000
#open namtrace file
set nf [open lab42.nam w]
$ns namtrace-all-wireless $nf 1000 1000
#specify node configuration
$ns node-config -adhocRouting DSDV \
-llType LL \
-macType Mac/802_11 \
-ifqType Queue/DropTail \
-ifqLen 20 \
-phyType Phy/WirelessPhy \
-channelType Channel/WirelessChannel \
-propType Propagation/TwoRayGround \
-antType Antenna/OmniAntenna \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON
#create General Operation Director(god) object that stores total number of mobile nodes.
create-god 4
#create nodes and label them
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
$n0 label "tcp0"
$n1 label "sink0"
$n2 label "bs1"
$n3 label "bs2"
#give initial x, y, z coordinates to nodes
$n0 set X_ 110
$n0 set Y_ 500
$n0 set Z_ 0
$n1 set X_ 600
$n1 set Y_ 500
$n1 set Z_ 0
$n2 set X_ 300
$n2 set Y_ 500
$n2 set Z_ 0
$n3 set X_ 450
$n3 set Y_ 500
$n3 set Z_ 0
#attach agent and application to nodes and connect them
set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp0 $sink1
#schedule the event
$ns at 0.5 "$ftp0 start"
#set up destination for mobile nodes. They move to <x><y> coordinates at <s>m/s.
$ns at 0.3 "$n0 setdest 110 500 10"
$ns at 0.3 "$n1 setdest 600 500 20"
$ns at 0.3 "$n2 setdest 300 500 30"
$ns at 0.3 "$n3 setdest 450 500 30"
$ns at 10.0 "$n0 setdest 100 550 5"
$ns at 10.0 "$n1 setdest 630 450 5"
$ns at 70.0 "$n0 setdest 170 680 5"
$ns at 70.0 "$n1 setdest 580 380 5"
$ns at 120.0 "$n0 setdest 140 720 5"
$ns at 135.0 "$n0 setdest 110 600 5"
$ns at 140.0 "$n1 setdest 600 550 5"
$ns at 155.0 "$n0 setdest 89 500 5"
$ns at 190.0 "$n0 setdest 100 440 5"
$ns at 210.0 "$n1 setdest 700 600 5"
$ns at 240.0 "$n1 setdest 650 500 5"
proc finish { } {
global ns nt nf
$ns flush-trace
exec nam lab42.nam &
close $nt
close $nf
exit 0
}
$ns at 400 "finish"
$ns run

