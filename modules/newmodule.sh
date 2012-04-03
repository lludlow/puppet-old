#!/bin/bash
#script to create new modules 

echo "Enter the nemae of the new module (All Lower Case)"
read module

echo "Are you sure you want to create a new modules named $module?"

select yn in "Yes" "No"; do
	case $yn in
	Yes ) echo "OK, here we go.."; break;;
	No ) exit; break;;
	esac
done


mkdir -p /linuxdist/puppet/modules/$module/{manifest,tests}
echo "# /linuxdist/puppet/modules/$module/manifest/init.pp" > /linuxdist/puppet/modules/$module/manifest/init.pp
echo "# /linuxdist/puppet/modules/$module/tests/init.pp" >/linuxdist/puppet/modules/$module/tests/init.pp

echo "# This is the same as 0.25.x" >>/linuxdist/puppet/modules/$module/tests/init.pp
echo "# include $module" >>/linuxdist/puppet/modules/$module/tests/init.pp
echo "class { '$module': }" >>/linuxdist/puppet/modules/$module/tests/init.pp
echo "import \"$module\"" >> /linuxdist/puppet/manifest/modules.pp
chown -Rf puppet:puppet /linuxdist/puppet/modules *
echo "All done creating new module $module located at /linuxdist/puppet/modules/$module"
echo "configuration files have been updated to include this new empty module"
exit
