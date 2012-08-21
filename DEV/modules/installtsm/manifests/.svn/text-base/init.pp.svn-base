# /linuxdist/puppet/modules/installtsm/manifests/init.pp

class installtsm { 

	if $operatingsystem == 'RedHat' { 
	
		case $operatingsystemrelease { 
			"6.2": { package { "glibc.i686":
						ensure => "installed",
					}
		
					package { "compat-libstdc++-296.i686":
						ensure => "installed",
					}

					package { "libstdc++.i686":
						ensure => "installed",
					}
			}
		}
	}
	
	file { "/mnt/linuxdist/scripts/puppet/installtsm.sh":
		ensure => present,
		owner => "root",
		group => "root",
		source => "/mnt/linuxdist/scripts/puppet/installtsm.sh",
	}
	
	exec { "/mnt/linuxdist/scripts/puppet/installtsm.sh":
		require => File["/mnt/linuxdist/scripts/puppet/installtsm.sh"],
		creates => "/opt/tivoli/tsm/client/ba/bin/dsm.opt",
	}
}