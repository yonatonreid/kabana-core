sudo sudo

apt-get update && apt-get upgrade
apt-get install -y gcc make autoconf libc-dev pkg-config automake libtool m4 build-essential dpkg-dev
apt-get install -y re2c libpcre3-dev software-properties-common
apt-get install -y ntp vim wget git-core git etckeeper
apt-get install -y ca-certificates gnupg ibgpgme11 libgpgme11-dev
apt-get install -y libssl-dev libffi-dev python-dev python3-pip tree
apt-get install -y libxml2 libxml2-dev libxml2-utils libaprutil1 libaprutil1-dev
apt-get install -y ipv6toolkit net-tools libssl-dev snapd
apt autoremove

apt-get build-dep curl
cd /tmp && mkdir curl && cd /tmp/curl
wget http://curl.haxx.se/download/curl-7.50.2.tar.bz2
tar -xvjf curl-7.50.2.tar.bz2
cd curl-7.50.2
./configure && make && make install
ldconfig

sshAgentBinaryLocation=$(which ssh-agent)
eval $($sshAgentBinaryLocation -s)
sshAddBinaryLocation=$(which ssh-add)
$sshAddBinaryLocation /root/.ssh/myssh
