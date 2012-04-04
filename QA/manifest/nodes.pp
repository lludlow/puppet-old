# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth
}

node /^lnxmgt\-dev\d+\.med\.umich\.edu/ inherits basenode {
}
