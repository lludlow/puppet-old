# /linuxdist/puppet/modules/installpsp/manifests/init.pp

class installpsp {

	if $is_virtual == 'false' {
	
		file { "/mnt/linuxdist/psp/870/hp/swpackages/hpsum":
			ensure => present,
			source => "/mnt/linuxdist/psp/870/hp/swpackages/hpsum",
		}
	
		file { "/mnt/linuxdist/scripts/puppet/installpsp.sh":
			ensure => present,
			source => "/mnt/linuxdist/scripts/puppet/installpsp.sh",
		}
	
		exec { "run_hpsum_install_script":
			command => "/mnt/linuxdist/scripts/puppet/installpsp.sh",
			creates => "/etc/init.d/hpsmhd",
		}
	}
}