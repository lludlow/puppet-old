# /etc/puppet/modules/stophpsmh/manifest/init.pp

service { "hpsmhd":
	ensure => "stopped",
	enabled => false
}