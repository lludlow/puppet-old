# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mountlinuxdist, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate, installpsp, installtripwire, installtsm, puppet-run
}
		
node default inherits basenode {
}

node /^lnxmgt/ {
include setbanner, rootprofile, syslogforward, locate, sudo, mailforward, puppet-run
}

node /^slp\d+$/ {
include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate, puppet-run
}

node /^lnxtest/ {
        include sudo, ldapauth, mountlinuxdist, mailforward, setntp, setbanner, rootprofile, syslogforward, locate, installpsp, installtripwire, installtsm, puppet-run
}

node /^lnxpup-rhel62/ {
        include sudo, ldapauth, mountlinuxdist, mailforward, setntp, setbanner, rootprofile, syslogforward, locate, installpsp, puppet-run, installtripwire, installtsm, usermaint
}
