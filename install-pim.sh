#!/bin/sh

# Example : install-pim.sh pee 1.5 /path/to/


APP=$1
BRANCH=$2
ROOT=$3

cd $ROOT/$APP

echo "Cloning EE"
git clone git@github.com:akeneo/pim-enterprise-dev.git .
git remote add fork git@github.com:aRn0D/pim-enterprise-dev.git
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

echo "Installing database"
app/console pim:install --force
app/console pim:install --force -e test

cd vendor/akeneo/pim-community-dev
git remote add fork git@github.com:aRn0D/pim-enterprise-dev.git
git checkout $BRANCH
