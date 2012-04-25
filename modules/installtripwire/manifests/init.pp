# /linuxdist/puppet/modules/installtripwire/manifest/init.pp

class installtripwire {
	file { "/mnt/linuxdist":
		path => "/mnt/linuxdist",
		ensure => directory
	}

	mount { "/mnt/linuxdist":
		device => "linuxdist.med.umich.edu:/linuxdist",
		fstype => nfs,
		options => "defaults",
		dump => 0,
		pass => 0,
		ensure => mounted
	}

	file { "/mnt/linuxdist/scripts/installtripwire.sh":
		ensure => present,
		owner => "root",
		group => "root",
		mode => "0755",
		source => "/mnt/linuxdist/scripts/installtripwire.sh",
	}
	
	exec { "/mnt/linuxdist/scripts/installtripwire.sh":
		require => File["/mnt/linuxdist/scripts/installtripwire.sh"]
	}
}