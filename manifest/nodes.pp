# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward, setntp
}

node default inherits basenode {
}
