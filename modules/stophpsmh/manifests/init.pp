# /etc/puppet/modules/stophpsmh/manifests/init.pp

class stophpsmh {

service { "hpsmhd":
	ensure => "stopped"
	}
}