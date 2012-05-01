# /etc/puppet/manifest/modules.pp

import "sudo"
import "ldapauth"
import "mailforward"
import "syslogforward"
import "mountlinuxdist"
import "setntp"
#import "synchwclock" #Broken
import "setbanner"
import "stophpsmh" 
#import "installtripwire"
#import "installtsm"
import "rootprofile"
import "sshkeys"
import "locate"
