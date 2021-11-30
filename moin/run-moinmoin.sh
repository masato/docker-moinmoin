#!/bin/bash
set -eo pipefail

echo "with SUPER_USER: $SUPER_USER"

mkdir -p /data/moin/pages
chown -R www-data:www-data /data/moin/pages/
chmod -R g+w /data/moin/pages/
chmod 2775 /data/moin/pages/

mkdir -p /data/moin/user
cp -f /backup/user /data/moin/user/1338720549.58.37773
chown -R www-data:www-data /data/moin/user/
chmod -R g+w /data/moin/user/
chmod 2775 /data/moin/user/

#if [ -d /data/moin/stylesheets ]; then
#  ln -sf /data/moin/stylesheets/common.css /usr/local/share/moin/htdocs/europython/css/common.css
#  ln -sf /data/moin/stylesheets/screen.css /usr/local/share/moin/htdocs/europython/css/screen.css
#fi

if [ -f /.moinmoin_created ]; then
    exec /run.sh
    exit 1
fi

sed -e "/sitename/s/Untitled //" \
    -e "/page_front_page.*Front/s/#\(page_front_page\)/\1/" \
    -e "/superuser/ { s/#\(superuser\)/\1/; s/YourName/$SUPER_USER/ }" \
    -e "/page_front_page/s/#u/u/" \
    -e "/acl_rights_before/s/.*/    acl_rights_default = u'$SUPER_USER:read,write,delete,revert,admin'\n&/"\
    -e "/theme_default/s/.*/    tz_offset = 9.0\n&/" \
   /usr/local/share/moin/config/wikiconfig.py > /usr/local/share/moin/wikiconfig.py

sed -i "/application/s/shared=True/'\/usr\/local\/share\/moin\/htdocs'/" /usr/local/share/moin/server/moin.wsgi

rm -r /usr/local/share/moin/data/{pages,user}
ln -sf /data/moin/pages /usr/local/share/moin/data/pages
ln -sf /data/moin/user /usr/local/share/moin/data/user

touch /.moinmoin_created
exec /run.sh
