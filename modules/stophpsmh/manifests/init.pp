# /etc/puppet/modules/stophpsmh/manifests/init.pp

service { "hpsmhd":
	ensure => "stopped"
	}