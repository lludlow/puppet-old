# /etc/puppet/modules/syslogforward/manifest/init.pp

class syslogforward {
	case $operatingsystem {
		SLES: {file { "/etc/syslog-ng/syslog.conf":
					ensure => file,
					owner => "root",
					group => "root",
					mode => 0644,
					source => "puppet:///files/syslogforward/SLES/syslog.conf"
			}
		}
		RedHat: {case $lsbmajdistrelease {
			5: {file { "/etc/syslog.conf":
					ensure => file,
					owner => "root",
					group => "root",
					mode => 0644,
					source => "puppet:///files/syslogforward/RedHat/syslog.conf"
					}
				}
			6: {file { "/etc/rsyslog.conf":
					ensure => file,
					owner => "root",
					group => "root",
					mode => 0644,
					source => "puppet:///files/syslogforward/RedHat/rsyslog.conf"
					}
				}
			default: { fail("Non provisioned version of Red Hat") }
			}
		}
		default: { fail("Non provisioned version of the Linux operating system") }
	}
}
