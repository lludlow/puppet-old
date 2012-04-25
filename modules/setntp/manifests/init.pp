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
			command => "/etc/init.d/ntp restart",
			}
		}
		RedHat: { exec { "restart ntpd":
			command => "/etc/init.d/ntpd restart",
			}
		}
	}
}
