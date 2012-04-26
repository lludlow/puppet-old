# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, synchwclock
}

node default inherits basenode {
}
