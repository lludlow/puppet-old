# /linuxdist/puppet/modules/mailforward/manifest/init.pp

class mailforward {
	file { "/root/.forward":
		ensure => file,
		owner => "root",
		group => "root",
		mode => 0644,
		source => "puppet:///files/mailforward/.forward"
	}
}