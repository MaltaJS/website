# MaltaJS website


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
$ elm package install -y
$ make all
$ yarn start
```

The app will be running on `localhost` at the port you specified (default is 3000).

## Environment variables

Not mandatory for development, used for deployment on Heroku.

* **MONGODB_URI** is the address to a db instance in the standard MongoDB URI format
* **AUTH_TOKEN** is the token to be used when retrieving the subscriber's list
* **MONGODB_PORT** works only if **MONGODB_URI** is not defined, is the local instance's port (default 27017)
* **PORT** is the port you want the server to bind (default 3000)

