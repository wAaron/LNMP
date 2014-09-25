#!/bin/bash

TEST()
{
cd $lnmp_dir/src
. ../functions/download.sh 
. ../options.conf

src_url=http://www.yahei.net/tz/tz.zip && Download_src
src_url=https://gist.githubusercontent.com/ck-on/4959032/raw/0b871b345fd6cfcd6d2be030c1f33d1ad6a475cb/ocp.php && Download_src

echo '<?php phpinfo() ?>' > $home_dir/public_html/phpinfo.php
/bin/cp $lnmp_dir/conf/index.html $home_dir/public_html
unzip -q tz.zip -d $home_dir/public_html
[ "$PHP_cache" == '1' ] && /bin/cp ocp.php $home_dir/public_html && sed -i 's@<a href="/xcache" target="_blank" class="links">xcache</a>@<a href="/ocp.php" target="_blank" class="links">Opcache</a>@' $home_dir/public_html/index.html
[ "$PHP_cache" == '3' ] && sed -i 's@<a href="/xcache" target="_blank" class="links">xcache</a>@<a href="/apc.php" target="_blank" class="links">APC</a>@' $home_dir/public_html/index.html
[ "$PHP_cache" == '4' ] && /bin/cp eaccelerator-*/control.php $home_dir/default && sed -i 's@<a href="/xcache" target="_blank" class="links">xcache</a>@<a href="/control.php" target="_blank" class="links">eAccelerator</a>@' $home_dir/public_html/index.html
[ "$Web_yn" == 'y' -a "$Nginx_version" != '3' -a "$Apache_version" != '3' ] && sed -i 's@LNMP@LANMP@g' $home_dir/public_html/index.html
[ "$Web_yn" == 'y' -a "$Nginx_version" == '3' -a "$Apache_version" != '3' ] && sed -i 's@LNMP@LAMP@g' $home_dir/public_html/index.html
chown -R www.www $home_dir/public_html
[ -e "$db_install_dir" -a -z "`ps -ef | grep -v grep | grep mysql`" ] && service mysqld start
[ -e "$apache_install_dir" -a -z "`ps -ef | grep -v grep | grep apache`" ] && service httpd restart 
cd ..
}