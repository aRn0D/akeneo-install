#!/bin/sh

# Example : install-all-pim.sh /path/to/

ROOT_INSTALLER=$(pwd)

sudo php5dismod xdebug; /etc/init.d/apache2 restart

$ROOT_INSTALLER/configure-vhost.sh "pee14" "$1"
$ROOT_INSTALLER/install-pim.sh "pee14" "1.4" "$1"

$ROOT_INSTALLER/configure-vhost.sh "peem14" "$1"
$ROOT_INSTALLER/install-pim.sh "peem14" "1.4" "$1"

$ROOT_INSTALLER/configure-vhost.sh "pee15" "$1"
$ROOT_INSTALLER/install-pim.sh "pee15" "1.5" "$1"

$ROOT_INSTALLER/configure-vhost.sh "peem15" "$1"
$ROOT_INSTALLER/install-pim.sh "peem15" "1.5" "$1"

$ROOT_INSTALLER/configure-vhost.sh "pee16" "$1"
$ROOT_INSTALLER/install-pim.sh "pee16" "1.6" "$1"

$ROOT_INSTALLER/configure-vhost.sh "peem16" "$1"
$ROOT_INSTALLER/install-pim.sh "peem16" "1.6" "$1"
