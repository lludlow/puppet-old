# /etc/puppet/modules/synchwclock/manifest/init.pp

exec { "sync hardware clock":
	command => "hwclock --systohc"
}