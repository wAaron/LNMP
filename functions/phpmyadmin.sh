#!/bin/bash

Install_phpMyAdmin()
{
cd $lnmp_dir/src
. ../functions/download.sh 
. ../options.conf 

src_url=http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.2.9/phpMyAdmin-4.2.9-all-languages.tar.gz && Download_src

tar xzf phpMyAdmin-4.2.9-all-languages.tar.gz
/bin/mv phpMyAdmin-4.2.9-all-languages $home_dir/public_html/phpMyAdmin
/bin/cp $home_dir/public_html/phpMyAdmin/{config.sample.inc.php,config.inc.php}
mkdir $home_dir/public_html/phpMyAdmin/{upload,save}
sed -i "s@UploadDir.*@UploadDir'\] = 'upload';@" $home_dir/public_html/phpMyAdmin/config.inc.php
sed -i "s@SaveDir.*@SaveDir'\] = 'save';@" $home_dir/public_html/phpMyAdmin/config.inc.php
chown -R www.www $home_dir/public_html/phpMyAdmin
cd ..
}