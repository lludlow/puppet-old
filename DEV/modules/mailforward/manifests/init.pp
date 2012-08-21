# /etc/puppet/modules/mailforward/manifests/init.pp

class mailforward {

	file { "/root/.forward":
       	owner => "root",
        group => "root",
        mode  => '0440',
		source => "puppet:///files/mailforward/forward",
		ensure => "present",
	}
}