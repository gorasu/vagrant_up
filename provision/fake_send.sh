#!/bin/sh 

sudo touch /vagrant/files/fake_sendmail.sh

sudo echo  '#!/bin/sh 

prefix="/vagrant/tmp/sendmail/new"
numPath="/vagrant/tmp/sendmail"

if [ ! -f $numPath/num ]; then 
echo "0" > $numPath/num 
fi 
num=`cat $numPath/num` 
num=$(($num + 1)) 
echo $num > $numPath/num 

name="$prefix/letter_$num.eml"
touch $name
chmod 777 $name
while read line 
do 
echo $line >> $name
done 
/bin/true' > /vagrant/files/fake_sendmail.sh

sudo chmod +x /vagrant/files/fake_sendmail.sh


sudo mkdir /vagrant/tmp/sendmail
cd /vagrant/tmp/sendmail
sudo mkdir cur
sudo mkdir new
sudo mkdir tmp
sudo chmod -R 777 /vagrant/tmp/sendmail

