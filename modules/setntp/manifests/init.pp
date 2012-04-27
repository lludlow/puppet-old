# /etc/puppet/modules/setntp/manifests/init.pp

  
class setntp {
	file { "/etc/ntp.conf":
		owner => "root",
		group => "root",
		mode => 0644,
		subscribe => File["/etc/ntp.conf"],
		refreshonly => true,
		source => "puppet:///files/setntp/$operatingsystem/ntp.conf"
	}
	
	file { "/etc/sysconfig/ntp":
		owner => "root",
		group => "root",
		mode => 0644,
		subscribe => File["/etc/sysconfig/ntp"],
		refreshonly => true,
		source => "puppet:///files/setntp/$operatingsystem/ntp"
	}
  schedule { daily:
    period => daily,
    range => "2 - 4",
  }
  
	case $operatingsystem {
		SLES: { exec { "restart ntp":
			schedule => daily,
			command => "/etc/init.d/ntp restart",
			}
		}
		RedHat: { exec { "restart ntpd":
			schedule => daily,
			command => "/etc/init.d/ntpd restart",
			}
		}
	}
}
