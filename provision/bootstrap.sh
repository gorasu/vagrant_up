#!/bin/bash

MARKER_FILE="/usr/local/etc/vagrant_provision_marker"
VAGRANT_WWW="/vagrant/www"

if [  -f "${MARKER_FILE}" ]
    then
    echo "OK";
    eit ;
fi
		   function createLink() {
				END_LINK_PATH=$1
				START_LINK_PATH=$2
				if [ ! -f "$1" ]
					then
					 sudo cp -r $START_LINK_PATH $END_LINK_PATH
					 sudo rm -r $START_LINK_PATH
					 END_OF_PATH=`basename "${START_LINK_PATH}"`
					 END_LINK_PATH=${END_LINK_PATH%/}'/'$END_OF_PATH					 
				fi
				if [ ! -f "$1" ]
					 then
					sudo touch "$1"
				fi

				 sudo ln -sf $END_LINK_PATH $START_LINK_PATH
		   }

            function createDir(){
            if [ ! -d "$1" ]; then
                mkdir $1
            fi
            }


		createDir /vagrant/www
		createDir /vagrant/files
		createDir /vagrant/files/vhosts
		createDir /vagrant/files/logs
		createDir /vagrant/tmp/
		createDir /vagrant/tmp/xdebug/
		createDir /vagrant/tmp/xdebug/tmp_xdebug
		createDir /vagrant/dumps
		createDir /vagrant/tmp/sendmail/
		createDir /vagvarant/tmp/sendmail/neweixt
		
		
#if [ ! -f "${MARKER_FILE}" ]
	#then
		sudo apt-get -y update
		createLink /vagrant/files/logs/ /var/log
		sudo apt-get -y install mc vim git apache2 libapache2-mod-php5 php5-mcrypt php5-cli
		sudo service apache2 restart


        cp -raT /etc/apache2/sites-available /etc/apache2/sites-enabled
	    rm /etc/apache2/sites-enabled/000-default.conf
	    createLink /vagrant/files/vhosts/ /etc/apache2/sites-enabled


	

		
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
        createLink /vagrant/files/ /etc/php5

        VALUE=`cat /vagrant/files/php5/conf.d/xdebug.ini`
echo  $VALUE'
;zend_extension=/usr/lib/php5/20090626+lfs/xdebug.so
xdebug.profiler_enable=0
xdebug.default_enable=1
xdebug.remote_enable=1
xdebug.remote_handler="dbgp"
xdebug.remote_host="localhost"
xdebug.remote_port=9000
xdebug.remote_autostart=0
xdebug.idekey=PHPSTORM
xdebug.remote_connect_back = 1
xdebug.profiler_output_dir = "/vagrant/tmp/xdebug/"' > /vagrant/files/php5/conf.d/xdebug.ini
	
    touch ${MARKER_FILE}
	#else
	#	echo "YES"
#fi


