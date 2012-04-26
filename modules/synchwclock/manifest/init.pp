# /etc/puppet/modules/synchwclock/manifest/init.pp

class synchwclock {
exec { "sync hardware clock":
	command => "hwclock --systohc"
}
}