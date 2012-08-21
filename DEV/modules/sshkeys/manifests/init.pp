# /etc/puppet/modules/sshkeys/manifests/init.pp

class sshkeys {


	file { "/root/.ssh":
			ensure => "directory",
        	owner => 'root',
	        group => 'root',
	        mode  => '0700'
    }
	file {"/root/.ssh/authorized_keys2":
			ensure => "file",
        	owner => 'root',
	        group => 'root',
	        mode  => '0640',
			source => "puppet:///files/sshkeys/authorized_keys2"	
	}
}
