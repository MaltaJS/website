# MaltaJS website

## Requirements

 - NodeJs >= 4.3.2
 - Npm >= 3.1.0
 - MongoDB

## Instructions

```
$ npm install

$ elm-package install

$ make all

$ npm start
```

The app will be running on `localhost` at the port you specified (default is 3000).

## Vagrant

### Install

* VirtualBox
* Vagrant

### Run the VM

```
$ vagrant up
$ vagrant ssh
```

### Build and run

```
$ cd /vagrant
$ yarn
$ elm package install
$ make all
$ yarn start
```

## Environment variables

* **MONGODB_URI** is the address to a db instance in the standard MongoDB URI format
* **AUTH_TOKEN** is the token to be used when retrieving the subscriber's list
* **MONGODB_PORT** works only if **MONGODB_URI** is not defined, is the local instance's port (default 27017)
* **PORT** is the port you want the server to bind (default 3000)

