# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate
}

node default inherits basenode {
}

node /^lnxmgt/ {
include setbanner, rootprofile, syslogforward, locate, sudo, mailforward
}

node /^slp\d+$/ {
include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate
}

