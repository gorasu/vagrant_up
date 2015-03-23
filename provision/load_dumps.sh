#!/bin/sh 

		LIST=$(ls -rt /vagrant/dumps/*.sql) # THIS LINE CHANGED

		for i in $LIST; do # THIS LINE CHANGED

			echo $i
			mysql --user=root --password=root < $i

		done
