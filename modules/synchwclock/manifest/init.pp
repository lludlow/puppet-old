# /etc/puppet/modules/synchwclock/manifests/init.pp

class synchwclock {
exec { "sync hardware clock":
	command => "/sbin/hwclock --systohc"
    }
}