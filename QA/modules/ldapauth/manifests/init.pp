# /linuxdist/puppet/modules/ldapauth/manifests/init.pp

class ldapauth {

	file { "/etc/pam.d/login":
		ensure => file,
        	owner => 'root',
	        group => 'root',
	        mode  => '0440',
		source => "puppet:///files/ldapauth/$operatingsystem/login"
    }

        file { "/etc/pam.d/su":
                ensure => file,
                owner => 'root',
                group => 'root',
                mode  => '0440',
                source => "puppet:///files/ldapauth/$operatingsystem/su"
	}

        file { "/etc/pam.d/sshd":
                ensure => file,
                owner => 'root',
                group => 'root',
                mode  => '0440',
                source => "puppet:///files/ldapauth/$operatingsystem/sshd"
        }

	file { "/etc/ldap.conf":
                ensure => file,
                owner => 'root',
                group => 'root',
                mode  => '0440',
                source => "puppet:///files/ldapauth/$operatingsystem/ldap.conf"
        }

	file { "/etc/crypt":
		ensure => directory,
		owner => 'root',
		group => 'root',
		mode => '0400'
	}
	
	exec { "copy-passwd":
		command => "cp /etc/passwd /etc/crypt/passwd_local",
		cwd => "/etc",
	}

        exec { "copy-shadow":
                command => "cp /etc/shadow /etc/crypt/shadow_local",
                cwd => "/etc",
        }

        file { "/etc/crypt/validate_user_passwd.sh":
                ensure => file,
                owner => 'root',
                group => 'root',
                mode  => '0700',
                source => "puppet:///files/ldapauth/$operatingsystem/validate_user_passwd.sh"
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

