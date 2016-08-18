#!/bin/sh

# Example : install-all-pim.sh /path/to/ odm

ROOT_INSTALLER=$(pwd)

sudo php5dismod xdebug; /etc/init.d/apache2 restart

$ROOT_INSTALLER/install-pim.sh "pee14" "1.4" "$1" "$2"
$ROOT_INSTALLER/install-pim.sh "peem14" "1.4" "$1" "$2" "odm"
$ROOT_INSTALLER/install-pim.sh "pee15" "1.5" "$1" "$2"
$ROOT_INSTALLER/install-pim.sh "peem15" "1.5" "$1" "$2" "odm"
$ROOT_INSTALLER/install-pim.sh "pee16" "1.6" "$1" "$2"
$ROOT_INSTALLER/install-pim.sh "peem16" "1.6" "$1" "$2" "odm"
$ROOT_INSTALLER/install-pim.sh "pee" "master" "$1" "$2"
$ROOT_INSTALLER/install-pim.sh "peem" "master" "$1" "$2" "odm"
