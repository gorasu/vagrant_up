
Vagrant.configure("2") do |c|
	c.vm.box = "hashicorp/precise32"
	c.vm.synced_folder  "www/","/var/www/", create:true, id:"vagrant-root",
                                                              owner: "vagrant",
                                                              group: "www-data",
                                                              mount_options: ["dmode=775,fmode=664"]
	c.vm.network :private_network, ip: "10.0.0.101"

	c.vm.provision "shell" do |s| 
		s.path = "bootstrap.sh"
	end

end