# /linuxdist/puppet/modules/sudo/manifests/init.pp

class sudo {

	package { sudo: ensure => latest }

	file { "/etc/sudoers":
        	owner => 'root',
	        group => 'root',
	        mode  => '0440',
		source => "puppet:///files/etc/sudoers",
		require => Package ["sudo"],
    }
}
