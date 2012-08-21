# /etc/puppet/modules/mountlinuxdist/manifests/init.pp

class mountlinuxdist {

	file { "/mnt/linuxdist":
		ensure => "directory",
	}

	mount { "/mnt/linuxdist":
		device => "linuxdist.med.umich.edu:/linuxdist",
		fstype => "nfs",
		options => "defaults",
		dump => '0',
		pass => '0',
		ensure => "mounted",
	}
}