# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward, setntp, setbanner, rootprofile, stophpsmh
}

node default inherits basenode {
}
