#!/bin/sh

#install cms

sudo apt-get update
# Feel free to change OpenJDK packages with your preferred JDK.
yes Y | sudo apt-get install build-essential openjdk-11-jdk-headless fp-compiler postgresql postgresql-client python3.8 cppreference-doc-en-html cgroup-lite libcap-dev zip
# Only if you are going to use pip/venv to install python dependencies
yes Y | sudo apt-get install python3.8-dev libpq-dev libcups2-dev libyaml-dev libffi-dev python3-pip
# Optional
yes Y | sudo apt-get install nginx-full python2.7 php7.4-cli php7.4-fpm  phppgadmin texlive-latex-base a2ps haskell-platform rustc mono-mcs

yes Y | git clone --recursive https://github.com/cms-dev/cms.git

cd cms
yes Y | sudo python3 prerequisites.py install

export SETUPTOOLS_USE_DISTUTILS="stdlib"
sudo --preserve-env=SETUPTOOLS_USE_DISTUTILS pip3 install -r requirements.txt
sudo --preserve-env=SETUPTOOLS_USE_DISTUTILS python3 setup.py install

#install tps
cd ~
yes Y | sudo apt-get install python 
git clone https://github.com/ioi-2017/tps.git
cd tps
sudo ./install-tps.sh


#gitlab sshkey
yes "" | ssh-keygen
sudo cp ~/.ssh/id_rsa.pub ~/id_rsa.pub

# echo '''
# #configuring the DB
# sudo su - postgres
# createuser --username=postgres --pwprompt cmsuser
# createdb --username=postgres --owner=cmsuser cmsdb
# psql --username=postgres --dbname=cmsdb --command='ALTER SCHEMA public OWNER TO cmsuser'
# psql --username=postgres --dbname=cmsdb --command='GRANT SELECT ON pg_largeobject TO cmsuser'
# '''

