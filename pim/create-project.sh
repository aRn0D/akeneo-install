#!/bin/sh

# Example : create-project.sh mondial-tissue 1.5 /home/arnaud/www/akeneo/pim/migration odm

REAL_SCRIPT=$(readlink -f $0)
ROOT_INSTALLER=$(dirname $REAL_SCRIPT)

$ROOT_INSTALLER/configure-vhost.sh "$1" "$3"
$ROOT_INSTALLER/install-pim.sh "$1" "$2" "$3" "$4"
