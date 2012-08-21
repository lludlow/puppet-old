# /etc/puppet/modules/sshd_config/manifests/init.pp
  
class sshd_config {

	file { "/etc/ssh/sshd_config":
		owner => "root",
		group => "root",
		mode => '0644',
		source => "puppet:///files/sshd_config/${operatingsystem}/sshd_config",
	}
	
	exec { "restart sshd":
			subscribe => File["/etc/ssh/sshd_config"],
			refreshonly => "true",
			command => "/etc/init.d/sshd restart",
			}
}
