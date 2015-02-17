#!/bin/bash

MARKER_FILE="/usr/local/etc/vagrant_provision_marker"
VAGRANT_WWW="/vagrant/www"


		mkdir /vagrant/www
		mkdir /vagrant/files
		mkdir /vagrant/files/vhosts
		mkdir /vagrant/files/logs
		mkdir /vagrant/tmp/
		mkdir /vagrant/tmp/xdebug/
		mkdir /vagrant/tmp/xdebug/tmp_xdebug
		mkdir /vagrant/dumps
		mkdir /vagrant/tmp/sendmail/
		mkdir /vagvarant/tmp/sendmail/neweixt

		   function createLink() {
			
				if [ ! -f "$1" ] 
					then
					 sudo cp -r $2 $1
					 sudo rm -r $2
				fi
				if [ ! -f "$1" ] 
					 then
					sudo touch "$1"
				fi
				
				 sudo ln -sf $1 $2
		   }	
		
		
if [ ! -f "${MARKER_FILE}" ] 
	then
		sudo apt-get -y update
		sudo apt-get -y install mc vim git apache2 libapache2-mod-php5 php5-mcrypt php5-cli
		sudo service apache2 restart


        cp -raT /etc/apache2/sites-available /etc/apache2/sites-enabled
	rm /etc/apache2/sites-enabled/000-default.conf
	createLink /vagrant/files/vhosts/ /etc/apache2/sites-enabled/
	createLink /vagrant/files/logs/ /var/log

	

		
		sudo apt-get -y install php5-dev curl php5-curl php5-gd php-pear
		sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
		sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
		sudo apt-get -y install mysql-server mysql-client php5-mysql
		
		
		#createLink /vagrant/files/my.cnf /etc/mysql/my.cnf

		 /etc/init.d/mysql restart
		
		LIST=$(ls -rt /vagrant/dumps/*.sql) # THIS LINE CHANGED

		for i in $LIST; do # THIS LINE CHANGED

			echo $i
			mysql --user=root --password=root < $i

		done

		sudo apt-get -y install php5-xdebug
		
		echo -e "root\nroot" | (sudo passwd )

        sudo service apache2 restart
        createLink /vagrant/files/php.ini /etc/php5/apache2/php.ini
	
		touch ${MARKER_FILE}
	else 
		echo "YES" 
fi 


