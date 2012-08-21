# /linuxdist/puppet/modules/usermaint/manifests/init.pp

class usermaint {

	file { "/etc/crypt/passwd_local":
		ensure  => present,
		content => template("usermaint/${hostname}/defaultusers.erb", "usermaint/${hostname}/ldapusers.erb", "usermaint/linuxteam.erb", "usermaint/common.erb"),
		audit   => content,
		notify  => File["/etc/passwd"],
		tag     => "telllinuxteam",
	}

	file { "/etc/passwd":
		ensure => present,
		source => "/etc/crypt/passwd_local",
		audit  => content,
		tag    => "telllinuxteam",
	}
}
