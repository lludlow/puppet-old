# /etc/puppet/modules/installtripwire/manifests/init.pp

class installtripwire {	
				
	case $architecture { 
		"x86_64": { file { "/mnt/linuxdist/tripwire/TE810/agent64/te_agent.bin":
						ensure => "present",
						source => "/mnt/linuxdist/tripwire/TE810/agent64/te_agent.bin",
					}
		
					exec { "run_tripwire_install_script":
						command => "/mnt/linuxdist/tripwire/TE810/agent64/te_agent.bin --eula accept --silent --install-rtm false --server-host 172.20.2.155 --server-port 9898 --passphrase 4tripWire2011",
						creates => "/etc/init.d/twdaemon",
					}
		}
	
		default: { file { "/mnt/linuxdist/tripwire/TE810/agent32/te_agent.bin":
						ensure => "present",
						source => "/mnt/linuxdist/tripwire/TE810/agent32/te_agent.bin",
					}
		
					exec { "run_tripwire_install_script":
						command => "/mnt/linuxdist/tripwire/TE810/agent32/te_agent.bin --eula accept --silent --install-rtm false --server-host 172.20.2.155 --server-port 9898 --passphrase 4tripWire2011",
						creates => "/etc/init.d/twdaemon",
					}
		}
	}
}