# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate, stophpsmh
}

node default inherits basenode {
}

node /^lnxmgt/ {
include setbanner, rootprofile, syslogforward, locate, sudo, mailforward
}

node /^slp\d+$/ {
include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate
}

node /^lnxvom-prod01/ {
        include sudo, mailforward, setntp, setbanner, rootprofile, syslogforward, locate, stophpsmh
}

node /^netapp-prod01/ {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, sshkeys, locate, stophpsmh
}