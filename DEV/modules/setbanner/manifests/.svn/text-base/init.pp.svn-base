# /etc/puppet/modules/setbanner/manifests/init.pp

class setbanner {

	file { "/etc/issue":
		owner => "root",
		group => "root",
		mode => '0644',
		source => "puppet:///files/setbanner/banner",
	}
	
	file { "/etc/issue.net":
		owner => "root",
		group => "root",
		mode => '0644',
		source => "puppet:///files/setbanner/banner",
	}

	file { "/etc/motd":
		owner => "root",
		group => "root",
		mode => '0644',
		source => "puppet:///files/setbanner/banner",
	}
}
