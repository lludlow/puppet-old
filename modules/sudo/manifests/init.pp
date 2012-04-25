# /etc/puppet/modules/sudo/manifests/init.pp

class sudo {


	file { "/etc/sudoers":
        	owner => 'root',
	        group => 'root',
	        mode  => '0440',
		source => "puppet:///files/etc/sudoers",
    }
}
