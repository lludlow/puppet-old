# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile
}

node default inherits basenode {
}
