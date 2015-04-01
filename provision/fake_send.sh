#!/bin/sh 

sudo touch /vagrant/files/fake_sendmail.sh

sudo echo  'prefix="/vagrant/tmp/sendmail/new"
numPath="/vagrant/tmp/sendmail"

if [ ! -f $numPath/num ]; then 
echo "0" > $numPath/num 
fi 
num=`cat $numPath/num` 
num=$(($num + 1)) 
echo $num > $numPath/num 

name="$prefix/letter_$num.txt"
while read line 
do 
echo $line >> $name
done 
chmod 777 $name
/bin/true' > /vagrant/files/fake_sendmail.sh

sudo chmod +x /vagrant/files/fake_sendmail.sh


sudo mkdir /vagrant/tmp/sendmail
cd /vagrant/tmp/sendmail
sudo mkdir cur
sudo mkdir new
sudo mkdir tmp
sudo chmod -R 777 /vagrant/tmp/sendmail

