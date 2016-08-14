# Installer

## Create an apache vhost

```
configure-vhost.sh project_name /path/to/
```

* **URLs:** project_name.akeneo.local and project_name-behat.akeneo.local
* **Document root:** /path/to/project_name
* **Log dir:** you need to update the var **$ROOT_LOG** in the file configure-vhost.sh


## Install a pim

```
install-pim.sh project_name branch /path/to/
```

**branch** is the git branch you want to checkout


## Install all stable versions

```
install-all-pim.sh /path/to/
```
