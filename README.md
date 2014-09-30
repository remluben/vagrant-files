# vagrant-files

A collection of vagrant files and install scripts for setting up different development environments for VMs

## Boilerplates

- [`LAMP`](./boilerplates/lamp)
 - Apache 2
 - PHP 5.5
 - MYSQL 
 - phpmyadmin
- [`Laravel LAMP`](./boilerplates/lamp-laravel)
 - Apache 2
 - PHP 5.5
 - MYSQL
 - phpmyadmin
 - composer
 - Laravel 4 framework project

## Requirements

As this repository contains vagrant setup boilerplate files, you need to have Vagrant installed on your machine. To do so please follow the instructions [Installing Vagrant](http://docs.vagrantup.com/v2/installation/)

## How to use

1. Clone this repo by executing `git clone https://github.com/remluben/vagrant-files.git`
2. Copy the required boilerplate files to your project root directory
3. Within your `/some/path/project/` directory execute `vagrant up`
4. Let vagrant do all the work
5. Start programming or login to the brand new VM using `vagrant ssh`

## Thanks to

- [https://github.com/JeffreyWay/Vagrant-Setup](https://github.com/JeffreyWay/Vagrant-Setup)
- [https://gist.github.com/fideloper/7074502](https://gist.github.com/fideloper/7074502)
- [Setting Up Vagrant With Laravel 4](http://culttt.com/2013/06/17/setting-up-vagrant-with-laravel-4/)
- [How to Install the Latest Version of PHP 5.5 on Ubuntu](http://www.dev-metal.com/how-to-setup-latest-version-of-php-5-5-on-ubuntu-12-04-lts/)
- [https://gist.github.com/rrosiek/8190550](https://gist.github.com/rrosiek/8190550)
