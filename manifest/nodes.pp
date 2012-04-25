# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth
}

node default inherits basenode {
}
