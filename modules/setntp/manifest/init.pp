# /linuxdist/puppet/modules/setntp/manifest/init.pp

class setntp {
	file { "/etc/ntp.conf":
		ensure => file,
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/setntp/ntp.conf"
	}
	
	file { "/etc/sysconfig/ntp":
		ensure => file,
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/setntp/ntp"
	}

	case $operatingsystem {
		SLES: { exec { "restart ntp":
			command => "/etc/init.d/ntp stop",
			command => "/etc/init.d/ntp ntptimeset",
			command => "/etc/init.d/ntp start"
			}
		}
		RedHat: { exec { "restart ntpd":
			command => "/etc/init.d/ntpd stop",
			command => "/etc/init.d/ntpd timeset",
			command => "/etc/init.d/ntpd start"
			}
		}
	}
}
