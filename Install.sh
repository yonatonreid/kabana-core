sudo su

### Core Ubuntu Packages Installation ###
apt-get update && apt-get upgrade
apt-get install -y gcc make autoconf libc-dev pkg-config automake libtool m4 build-essential dpkg-dev
apt-get install -y re2c libpcre3-dev software-properties-common
apt-get install -y ntp vim wget git-core git etckeeper
apt-get install -y ca-certificates gnupg ibgpgme11 libgpgme11-dev
apt-get install -y libssl-dev libffi-dev python-dev python3-pip tree
apt-get install -y libxml2 libxml2-dev libxml2-utils libaprutil1 libaprutil1-dev
apt-get install -y ipv6toolkit net-tools libssl-dev snapd
apt autoremove

### Curl Installation ###
apt-get build-dep curl
cd /usr/local/src && mkdir curl && cd /usr/local/src/curl
wget http://curl.haxx.se/download/curl-7.72.0.tar.bz2
tar -xvjf curl-7.72.0.tar.bz2
cd curl-7.72.0
./configure && make && make install
ldconfig

### Golang Installation ###
cd /usr/local/src && mkdir golang && cd /usr/local/src/golang
wget https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
tar xvf go1.15.2.linux-amd64.tar.gz
mv /usr/local/src/golang/go /usr/local/go

### SSH-Agent Installation ###
sshAgentBinaryLocation=$(which ssh-agent)
eval $($sshAgentBinaryLocation -s)
sshAddBinaryLocation=$(which ssh-add)
$sshAddBinaryLocation /root/.ssh/myssh
