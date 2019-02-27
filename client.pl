use IO::Socket::INET;

sub openFileInInput {
    open(my $in,  "<",  "input/hello-world.txt")  or die "Can't open input.txt: $!\n";
    print "File opened succesfully!\n";
    return $in
}

# auto-flush on socket
$| = 1;
 
print "creating a connecting socket...\n";
# create a connecting socket
my $socket = new IO::Socket::INET (
    PeerHost => '127.0.0.1',
    PeerPort => '7777',
    Proto => 'tcp',
);
die "cannot connect to the server $!\n" unless $socket;
print "connected to the server\n";


# data to send to a server
my $data = openFileInInput();
my $size = $socket->send($data);
print "sent data of length $size\n";
 
# notify server that request has been sent
shutdown($socket, 1);
 
# receive a response of up to 1024 characters from server
my $response = "";
$socket->recv($response, 1024);
print "received response: $response\n";
 
$socket->close();