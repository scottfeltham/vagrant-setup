#!/bin/sh
tabs 4
clear

echo 'Installing initial build tools....'
sudo apt-get update > /dev/null
sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip curl wget git > /dev/null

echo 'installing Java 7 jdk....'
sudo add-apt-repository -y ppa:webupd8team/java > /dev/null
sudo apt-get update > /dev/null
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java7-installer

echo 'export JAVA_HOME="/usr/lib/jvm/java-7-oracle" ' >> ~/.bashrc

echo 'setup Workspace'
workspace=/vagrant/Applications/hmrc-development-environment/hmrc/
mkdir -p $workspace

echo 'export WORKSPACE=$workspace' >> ~/.bashrc
. ~./bashrc

echo 'installing MongoDB....'
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 > /dev/null
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y mongodb-org=2.6.5 mongodb-org-server=2.6.5 mongodb-org-shell=2.6.5 mongodb-org-mongos=2.6.5 mongodb-org-tools=2.6.5 > /dev/null
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

echo 'installing scala and sbt....'
curl -LOk www.scala-lang.org/files/archive/scala-2.11.1.deb > /dev/null
sudo dpkg -i scala-2.11.1.deb > /dev/null
rm scala-2.11.1.deb
curl -LOk http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb > /dev/null
sudo dpkg -i sbt-0.13.5.deb > /dev/null
rm sbt-0.13.5.deb

echo 'installing Service manager....'
sudo apt-get install -y python > /dev/null
sudo apt-get install -y python-pip > /dev/null
sudo pip install servicemanager > /dev/null
