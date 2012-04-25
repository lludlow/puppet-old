# /etc/puppet/manifest/nodes.pp


node basenode {
        include sudo, ldapauth
		import "resolver"
resolv_conf { "example":
                  domainname  => "med.umich.edu",
                  searchpath  => ['med.umich.edu', 'mcit.med.umich.edu'],
                  nameservers => ['172.20.1.252', '172.20.1.244', '141.214.1.244'],
  }
}

node default inherits basenode {
}
