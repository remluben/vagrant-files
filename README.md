# vagrant-files

A collection of vagrant files and install scripts for setting up different development environments for Ubuntu VMs on 32-bit machines

## Boilerplates

- [`LAMP`](./boilerplates/lamp)
 - Ubuntu 14.04 LTS (32-bit)
 - Apache 2
 - PHP 7.1
 - MYSQL
 - MYSQL adminer
- [`Laravel 5.5 LAMP`](./boilerplates/lamp-laravel)
 - Ubuntu 14.04 LTS (32-bit)
 - Apache 2
 - PHP 7.1
 - MYSQL
 - MYSQL adminer
 - composer
 - Laravel 5.5 framework project

## Requirements

As this repository contains vagrant setup boilerplate files, you need to have Vagrant installed on your machine. To do so please follow the instructions [Installing Vagrant](http://docs.vagrantup.com/v2/installation/)

### Operating system

These boilerplates are tested and working on Ubuntu 14.04.

## How to use

1. Clone this repo by executing `git clone https://github.com/remluben/vagrant-files.git`
2. Copy the required boilerplate files to your project root directory
3. Within your `/some/path/project/` directory execute `vagrant up`
4. Let vagrant do all the work
5. Start programming or login to the brand new VM using `vagrant ssh`
6. Access the webserver root directory using [http://localhost:8080](http://localhost:8080)
7. Access the MYQL adminer database administration tool using [http://localhost:8081](http://localhost:8081) using user *root* and no password

### Default database credentials

User:     root

Password: root

Database: development

## Thanks to

- [https://github.com/JeffreyWay/Vagrant-Setup](https://github.com/JeffreyWay/Vagrant-Setup)
- [https://gist.github.com/fideloper/7074502](https://gist.github.com/fideloper/7074502)
- [Setting Up Vagrant With Laravel 4](http://culttt.com/2013/06/17/setting-up-vagrant-with-laravel-4/)
- [How to Install the Latest Version of PHP 5.5 on Ubuntu](http://www.dev-metal.com/how-to-setup-latest-version-of-php-5-5-on-ubuntu-12-04-lts/)
- [https://gist.github.com/rrosiek/8190550](https://gist.github.com/rrosiek/8190550)
