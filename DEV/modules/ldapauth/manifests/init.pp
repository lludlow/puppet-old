# /etc/puppet/modules/ldapauth/manifests/init.pp

class ldapauth {

	file { "/tmp/ldap_authentication":
		ensure => file,
        	owner => 'root',
	        group => 'root',
	        mode  => '0740',
		source => "puppet:///files/ldapauth/$operatingsystem/$lsbmajdistrelease/ldap_authentication"
    }

		file { "/etc/crypt/validate_user_passwd.sh":
		ensure => file,
        	owner => 'root',
	        group => 'root',
	        mode  => '0740',
		source => "puppet:///files/ldapauth/validate_user_passwd.sh"
    }
# execute ldap script 
	exec { "/tmp/ldap_authentication":
		cwd => "/tmp",
		creates => "/etc/passwd_preldap",
		path => "/usr/bin:/usr/sbin:/bin"
	}
	
	cron { ldap_auth:
		command => "/etc/crypt/validate_user_passwd.sh",
		user => root,
		hour => 2
	}
	
# execute validate users script only when it changes
	exec { "/etc/crypt/validate_user_passwd.sh":
		cwd => "/etc/crypt",
		path => "/usr/bin:/usr/sbin:/bin",
		subscribe => File["/etc/crypt/validate_user_passwd.sh"],
		refreshonly => true
	}
}

