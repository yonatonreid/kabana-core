#!/bin/bash
if [[ $(id -u) != 0 ]] ; then
    echo "Must be run as root" >&2
    exit 1
fi

### Core Ubuntu Packages Installation ###
apt-get update && apt-get upgrade
apt-get install -y gcc make autoconf libc-dev pkg-config automake libtool m4 build-essential dpkg-dev
apt-get install -y re2c libpcre3-dev software-properties-common
apt-get install -y ntp vim wget git-core git etckeeper
apt-get install -y apt-transport-https ca-certificates gnupg ibgpgme11 libgpgme11-dev
apt-get install -y libssl-dev libffi-dev python-dev python3-pip tree
apt-get install -y libxml2 libxml2-dev libxml2-utils libaprutil1 libaprutil1-dev
apt-get install -y ipv6toolkit net-tools libssl-dev snapd
apt autoremove
echo "Ubuntu Software Installed Successfully"

### Curl Installation ###
apt-get build-dep curl
wget http://curl.haxx.se/download/curl-7.72.0.tar.bz2 -P /tmp
tar -xvjf /tmp/curl-7.72.0.tar.bz2 -C /usr/local/src
cd curl-7.72.0 || exit
./configure && make && make install
ldconfig
echo "Curl Installed Successfully"

### Java Installation ###
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java9-installer
echo "JAVA_HOME=/usr/lib/jvm/java-9-oracle" >> /etc/environment
source /etc/environment
echo "Oracle Java JDK 9 Installed Successfully"

### Maven Installation ###
wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
ln -s /opt/apache-maven-3.6.3 /opt/maven
touch /etc/profile.d/maven.sh
echo "export M2_HOME=/opt/maven" >> /etc/profile.d/maven.sh
echo "export MAVEN_HOME=/opt/maven" >> /etc/profile.d/maven.sh
echo "export PATH=${M2_HOME}/bin:${PATH}" >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
echo "Maven Installed Successfully"

### Redis Installation ###
apt install redis-server
systemctl stop redis-server
sed -e '/^supervised no/supervised systemd/' \
    -e 's/^# *bind 127\.0\.0\.1 ::1/bind 127.0.0.1 ::1' \
    /etc/redis/redis.conf >/etc/redis/redis.conf.new
mv /etc/redis/redis.conf /etc/redis/redis.conf.$(date +%y%b%d-%H%M%S)
mv /etc/redis/redis.conf.new /etc/redis/redis.conf
systemctl start redis-server
sleep 1
if [[ "$( echo 'ping' | /usr/bin/redis-cli )" == "PONG" ]] ; then
    echo "Redis Installed Successfully"
else
    echo "Redis Failed Installation"
fi
systemctl status redis
systemctl status redis-server

### Golang Installation ###
wget https://golang.org/dl/go1.15.2.linux-amd64.tar.gz -P /tmp
tar xvf go1.15.2.linux-amd64.tar.gz -C /usr/local/src
mv /usr/local/src/go /usr/local/go
echo "export PATH=$PATH:$(go env GOPATH)/bin" >> /root/.profile
source /root/.profile
echo "Golang Installed Successfully"

### Docker Installation ###
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
apt-get update
apt-get install docker-ce
echo "Docker Installed Successfully"

### SSH-Agent Installation ###
sshAgentBinaryLocation=$(which ssh-agent)
eval $($sshAgentBinaryLocation -s)
sshAddBinaryLocation=$(which ssh-add)
$sshAddBinaryLocation /root/.ssh/id_rsa
echo "SSH Key Added to SSH Agent"

exit 0