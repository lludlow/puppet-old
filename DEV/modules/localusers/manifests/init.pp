# /linuxdist/puppet/modules/localusers/manifests/init.pp

class localusers {

	case $hostname {
		'lnxapp-prod01': {
			file { "puppet:///modules/usermaint/templates/${hostname}/ldap.erb":
			    replace => "no",
			    ensure  => "present",
			    source  => "puppet:///files/localusers/defaultuserste",
			    mode    => 640,
			}
		}
		
		default: {
			file { "puppet:///modules/usermaint/templates/${hostname}/ldap.erb":
			    replace => "no",
			    ensure  => "present",
			    source  => "puppet:///files/localusers/defaultusers",
			    mode    => 640,
			}
		}
	}
}