# /etc/puppet/modules/setbanner/manifest/init.pp

class setbanner {
	file { "/etc/issue":
		ensure => file,
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/setbanner/banner"
	}
	
	file { "/etc/issue.net":
		ensure => file,
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/setbanner/banner"
	}

	file { "/etc/motd":
		ensure => file,
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/setbanner/banner"
	}
}
