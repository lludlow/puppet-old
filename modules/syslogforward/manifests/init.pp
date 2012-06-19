# /etc/puppet/modules/syslogforward/manifests/init.pp
##
##LNXMGT servers are excluded in nodes.pp from the syslogforward manifest since they are the syslog servers.
##
class syslogforward {

	case $operatingsystem {
		SLES: {file { "/etc/syslog-ng/syslog-ng.conf":
					owner => "root",
					group => "root",
					mode => '0644',
					source => "puppet:///files/syslogforward/SLES/syslog.conf",
			}
			exec { "/etc/init.d/syslog restart":
			cwd => "/etc/init.d",
			path => "/usr/bin:/usr/sbin:/bin",
			subscribe => File["/etc/syslog-ng/syslog-ng.conf"],
			refreshonly => true
			}
		}
		
		RedHat: {case $lsbmajdistrelease {
			5: {file { "/etc/rsyslog.conf":
					owner => "root",
					group => "root",
					mode => '0644',
					source => "puppet:///files/syslogforward/RedHat/rsyslog.conf",
					}
					package { "rsyslog":
						ensure => "installed",
					}
					exec { "/etc/init.d/rsyslog restart":
					cwd => "/etc/init.d",
					path => "/usr/bin:/usr/sbin:/bin",
					subscribe => File["/etc/rsyslog.conf"],
					require => Exec ["/etc/init.d/syslog stop"],
					refreshonly => true,
					}
					exec { "/etc/init.d/syslog stop":
					cwd => "/etc/init.d",
					require => Package ["rsyslog"],
					}

				}
				
			6: {file { "/etc/rsyslog.conf":
					owner => "root",
					group => "root",
					mode => '0644',
					source => "puppet:///files/syslogforward/RedHat/rsyslog.conf",
					}
					exec { "/etc/init.d/rsyslog restart":
					cwd => "/etc/init.d",
					path => "/usr/bin:/usr/sbin:/bin",
					subscribe => File["/etc/rsyslog.conf"],
					refreshonly => true
					}
				}
			default: { fail("Non provisioned version of Red Hat") }
			}
		}
		default: { fail("Non provisioned version of the Linux operating system") }
	}
}
