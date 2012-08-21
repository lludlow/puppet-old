# /etc/puppet/modules/puppet-run/manifests/init.pp

class puppet-run {
 $first = fqdn_rand(20)
 $second = fqdn_rand(20) + 30

	file { "/etc/cleancron":
		owner => "root",
		group => "root",
		mode => 0600,
		source => "puppet:///files/etc/cleancron",
	}
	
#	exec {clean-cron:
#		command => "crontab -l | sed '\/15/d' | crontab -",
#		subscribe => File["/etc/cleancron"],
#		refreshonly => true,
#		}
		
	cron { puppet-run:
		command => "/usr/bin/puppet agent --onetime --server lnxpup-dev01.med.umich.edu > /dev/null",
		user => "root",
		minute => [ $first, $second ],
		ensure => present,
	}
}
