#!/bin/sh

# Example : configure-vhost.sh pee /path/to/

REAL_SCRIPT=$(readlink -f $0)
ROOT_INSTALLER=$(dirname $REAL_SCRIPT)
APP=$1
ROOT_APP=$2/$APP

# Change it manually if you want to store somewhere else
ROOT_LOG=$ROOT_INSTALLER/../logs/$APP


if [ ! -d "$ROOT_LOG" ]; then
    echo "Creating $ROOT_LOG"
    mkdir -p $ROOT_LOG
fi

if [ ! -d "$ROOT_APP" ]; then
    echo "Creating $ROOT_APP"
    mkdir -p $ROOT_APP
fi

if ! grep "$APP.akeneo.local" /etc/hosts; then
    echo "Adding hosts $APP.akeneo.local"
    echo "127.0.0.1 $APP.akeneo.local $APP-behat.akeneo.local" | sudo tee --append /etc/hosts
fi

echo "Creating default vhost"
APACHE_VHOST="/etc/apache2/sites-available/pim2_"$APP".conf"
sudo cp $ROOT_INSTALLER"/apache/default_vhost" $APACHE_VHOST
sudo sed -i "s#\[URL\]#$APP.akeneo.local#" $APACHE_VHOST
sudo sed -i "s#\[ROOT_DIR\]#$ROOT_APP#" $APACHE_VHOST
sudo sed -i "s#\[ROOT_LOG\]#$ROOT_LOG#" $APACHE_VHOST
sudo sed -i "s#\[APP\]#$APP#" $APACHE_VHOST

echo "Creating behat vhost"
BEHAT_APACHE_VHOST="/etc/apache2/sites-available/pim2_"$APP"_behat.conf"
sudo cp $ROOT_INSTALLER"/apache/behat_vhost" $BEHAT_APACHE_VHOST
sudo sed -i "s#\[URL\]#$APP-behat.akeneo.local#" $BEHAT_APACHE_VHOST
sudo sed -i "s#\[ROOT_DIR\]#$ROOT_APP#" $BEHAT_APACHE_VHOST
sudo sed -i "s#\[ROOT_LOG\]#$ROOT_LOG#" $BEHAT_APACHE_VHOST
sudo sed -i "s#\[APP\]#$APP#" $BEHAT_APACHE_VHOST

echo "Enabling vhost"
cd /etc/apache2/sites-available; sudo a2ensite "pim2_"$APP".conf"
cd /etc/apache2/sites-available; sudo a2ensite "pim2_"$APP"_behat.conf"

echo "Restarting Apache"
sudo service apache2 reload
