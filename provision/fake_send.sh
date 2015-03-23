#!/bin/sh 

sudo touch /vagrant/files/fake_sendmail.sh

sudo echo  'prefix="/var/mail/sendmail/new"
numPath="/var/mail/sendmail"

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

sudo mkdir /var/mail
sudo mkdir /var/mail/sendmail
cd /var/mail/sendmail
sudo mkdir cur
sudo mkdir new
sudo mkdir tmp
sudo chmod -R 777 /var/mail/sendmail

