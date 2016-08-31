#!/bin/sh

# Example : install-all-pim.sh /path/to/

REAL_SCRIPT=$(readlink -f $0)
ROOT_INSTALLER=$(dirname $REAL_SCRIPT)

sudo php5dismod xdebug; /etc/init.d/apache2 restart

$ROOT_INSTALLER/create-project "pee14" "1.4" "$1"
$ROOT_INSTALLER/create-project.sh "peem14" "1.4" "$1" "odm"
$ROOT_INSTALLER/create-project.sh "pee15" "1.5" "$1"
$ROOT_INSTALLER/create-project.sh "peem15" "1.5" "$1" "odm"
$ROOT_INSTALLER/create-project.sh "pee16" "1.6" "$1"
$ROOT_INSTALLER/create-project.sh "peem16" "1.6" "$1" "odm"
$ROOT_INSTALLER/create-project.sh "pee" "master" "$1"
$ROOT_INSTALLER/create-project.sh "peem" "master" "$1" "odm"
