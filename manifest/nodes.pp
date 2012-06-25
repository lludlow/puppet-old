# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate, stophpsmh, puppet-run
}

node default inherits basenode {
}

node /^lnxmgt/ {
include setbanner, rootprofile, locate, sudo, mailforward, puppet-run
}

node /^slp\d+$/ {
include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, syslogforward, sshkeys, locate, puppet-run
}

node /^lnxvom-prod01/ {
        include sudo, mailforward, setntp, setbanner, rootprofile, syslogforward, locate, stophpsmh, puppet-run
}

node /^netapp-prod01/ {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, sshkeys, locate, stophpsmh, puppet-run
}