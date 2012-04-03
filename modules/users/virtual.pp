# /linuxdist/puppet/modules/users/virtual.pp
# Accounts used as system accounts

class sysusers {
	@user { "scopemonitor":
        ensure  => "present",
        uid     => "241298",
        gid     => "10",
        comment => "Site Scope User",
        home    => "/home/scopemonitor",
        shell   => "/bin/bash",
	}

	@user { "puppet":
        ensure  => "present",
        uid     => "108",
        gid     => "10",
        comment => "Puppet daemon",
        home    => "/var/lib/puppet",
        shell   => "/bin/false",
        }
}
