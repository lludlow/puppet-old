# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth, mailforward
}

node default inherits basenode {
}
