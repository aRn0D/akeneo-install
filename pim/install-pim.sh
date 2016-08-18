#!/bin/sh

# Example : install-pim.sh pee 1.5 /path/to/ odm


APP=$1
BRANCH=$2
ROOT=$3
STORAGE=$4

cd $ROOT/$APP

echo "Cloning EE"
git clone git@github.com:akeneo/pim-enterprise-dev.git .
git remote set-url origin --push git@github.com:aRn0D/pim-enterprise-dev.git
git checkout $BRANCH

echo "Installing dependencies"
composer install --no-interaction

echo "Editing configuration"
cp app/config/parameters.yml.dist app/config/parameters.yml
sed -i "s#database_name:     akeneo_pim#database_name: pim_$APP#" app/config/parameters.yml
sed -i "s#database_user:     akeneo_pim#database_user: pim#" app/config/parameters.yml
sed -i "s#database_password: akeneo_pim#database_password: pim#" app/config/parameters.yml

cp app/config/parameters.yml app/config/parameters_test.yml
sed -i "s#database_name: pim_$APP#database_name: pim_$APP\_behat#" app/config/parameters_test.yml
echo "    installer_data: PimEnterpriseInstallerBundle:minimal" | sudo tee --append app/parameters_test.yml app/config/parameters_test.yml

if [ "$STORAGE" = "odm" ]; then
    composer require doctrine/mongodb-odm-bundle
    sed -i 's/\( *\)\/\/ \(new Doctrine\\Bundle\\MongoDBBundle\\DoctrineMongoDBBundle.*\)/\1\2/' app/AppKernel.php

    echo "    mongodb_server: 'mongodb://localhost:27017'" | sudo tee --append app/config/parameters.yml
    echo "    mongodb_database: 'pim_$APP'" | sudo tee --append app/config/parameters.yml
    echo "    pim_catalog_product_storage_driver: doctrine/mongodb-odm" | sudo tee --append app/config/parameters.yml

    echo "    mongodb_database: 'pim_"$APP"_behat'" | sudo tee --append app/parameters_test.yml app/config/parameters_test.yml
fi

echo "Installing database"
app/console pim:install --force
app/console pim:install --force -e test

echo "Configuring Behat"
cp behat.yml.dist behat.yml
sed -i "s#http://akeneo-pim-enterprise-behat.local/#http://$APP-behat.local/#" app/config/parameters.yml

echo "Configuring CE Git settings"
cd vendor/akeneo/pim-community-dev
git remote set-url origin --push git@github.com:aRn0D/pim-community-dev.git
git checkout $BRANCH
