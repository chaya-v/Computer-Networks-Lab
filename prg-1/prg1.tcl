#Create Simulator object
set ns [new Simulator]

#Open trace file
set nt [open lab1.tr w]
$ns trace-all $nt

#Open namtrace file
set nf [open lab1.nam w]
$ns namtrace-all $nf

#Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Assign color to the packet
$ns color 1 Blue
$ns color 2 Red

#label nodes
$n0 label "Source/udp0"
$n1 label "Source/udp1"
$n2 label "Router"
$n3 label "Destination/null"

#create links, specify the type, nodes, bandwidth, delay and ARQ algorithm for it
$ns duplex-link $n0 $n2 10Mb 300ms DropTail
$ns duplex-link $n1 $n2 10Mb 300ms DropTail
$ns duplex-link $n2 $n3 100Kb 300ms DropTail

#set queue size between the nodes
$ns queue-limit $n0 $n2 10
$ns queue-limit $n1 $n2 10
$ns queue-limit $n2 $n3 20

#create and attach UDP agent to n0, n1 and Null agent to n3
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set null3 [new Agent/Null]
$ns attach-agent $n3 $null3

#attach Application cbr to udp
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

#set udp0 packet to red color and udp1 packet to
#set udp0 packet to red color and udp1 packet to blue color
$udp0 set class_ 1
$udp1 set class_ 2

#connect the agents
$ns connect $udp0 $null3
$ns connect $udp1 $null3

#set packet size and interval for cbr1
$cbr1 set packetSize_ 500Mb
$cbr1 set interval_ 0.005

#finish procedure
proc finish { } {
global ns nf nt
$ns flush-trace
exec nam lab1.nam &
close $nt
close $nf
exit 0
}
$ns at 0.1 "$cbr0 start"
$ns at 0.1 "$cbr1 start"
$ns at 10.0 "finish"
$ns run
