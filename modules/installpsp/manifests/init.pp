# /linuxdist/puppet/modules/installpsp/manifests/init.pp

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

	file { "/mnt/linuxdist/psp/870/hpsum":
		ensure => present,
		owner => "root",
		group => "root",
		mode => "0755",
		source => "/mnt/linuxdist/psp/870/hpsum",
	}
	
	exec { "/mnt/linuxdist/psp/870/hpsum -inputfile hpsum870input.txt":
		require => File["/mnt/linuxdist/psp/870/hpsum"]
	}
}