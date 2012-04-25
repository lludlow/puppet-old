# /etc/puppet/modules/setntp/manifests/init.pp

class setntp {
	file { "/etc/ntp.conf":
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/setntp/$operatingsystem/ntp.conf"
	}
	
	file { "/etc/sysconfig/ntp":
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/setntp/$operatingsystem/ntp"
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
