# /etc/puppet/manifest/site.pp
import "nodes"
import "modules"

filebucket { main: server => 'puppet.med.umich.edu' }
File { backup => main }
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

#Package {
#    provider => $operatingsystem ? {
#        SLES => zypper,
#        redhat => yum
#    }
#}
