sudo su

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

### Curl Installation ###
apt-get build-dep curl
cd /usr/local/src && mkdir curl && cd /usr/local/src/curl || exit
wget http://curl.haxx.se/download/curl-7.72.0.tar.bz2
tar -xvjf curl-7.72.0.tar.bz2
cd curl-7.72.0 || exit
./configure && make && make install
ldconfig

### Java Installation ###
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java9-installer
echo "JAVA_HOME=/usr/lib/jvm/java-9-oracle" >> /etc/environment
source /etc/environment

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

### Golang Installation ###
cd /usr/local/src && mkdir golang && cd /usr/local/src/golang || exit
wget https://golang.org/dl/go1.15.2.linux-amd64.tar.gz
tar xvf go1.15.2.linux-amd64.tar.gz
mv /usr/local/src/golang/go /usr/local/go
echo "export PATH=$PATH:$(go env GOPATH)/bin" >> /root/.profile
source /root/.profile

### Docker Installation ###
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
apt-get update
apt-get install docker-ce

### SSH-Agent Installation ###
sshAgentBinaryLocation=$(which ssh-agent)
eval $($sshAgentBinaryLocation -s)
sshAddBinaryLocation=$(which ssh-add)
$sshAddBinaryLocation /root/.ssh/myssh
