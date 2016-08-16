#!/bin/bash

# Firefox 38.4
# Selenium 2.48.2

REAL_SCRIPT=$(readlink -f $0)
SELENIUM_DIR=$(dirname $REAL_SCRIPT)
FIREFOX_DIR=$SELENIUM_DIR"/firefox"

export PATH=$FIREFOX_DIR:$PATH

java -jar $SELENIUM_DIR/selenium-server.jar
