# /etc/puppet/modules/locate/manifests/init.pp

  
class locate {
	file { "/etc/sysconfig/locate":
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/locate/locate"
	}
}
