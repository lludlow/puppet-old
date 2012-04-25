# /etc/puppet/modules/mailforward/manifest/init.pp

class mailforward {

	file { "/root/.forward":
			owner => "root",
			group => "root",
			mode => 0644,
		source => "puppet:///files/mailforward/forward",
	}
}