# /linuxdist/puppet/modules/installtsm/manifests/init.pp

class installtsm {
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

	file { "/mnt/linuxdist/scripts/installtsm.sh":
		ensure => present,
		owner => "root",
		group => "root",
		mode => "0755",
		source => "/mnt/linuxdist/scripts/installtsm.sh",
	}
	
	exec { "/mnt/linuxdist/scripts/installtsm.sh":
		require => File["/mnt/linuxdist/scripts/installtsm.sh"]
	}
}