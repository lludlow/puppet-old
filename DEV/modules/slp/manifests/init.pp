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
			subscribe => File["/etc/ntp.conf"],
			refreshonly => true,
			command => "/etc/init.d/ntp restart",
			}
		}
		RedHat: { exec { "restart ntpd":
			subscribe => File["/etc/ntp.conf"],
			refreshonly => true,
			command => "/etc/init.d/ntpd restart",
			}
		}
	}
}
