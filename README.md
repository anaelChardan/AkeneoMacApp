# Akeneo for Mac (using Docker)

## GOAL

The main goal is to easily manage your differents PIMs already installed on your MAC in order to avoid the usage of the command line for usual testing.

For example:
- Boot a PIM
- Open a PIM in Browser
- Shutdown a PIM
- Initialize a PIM
- ...

The second goal is to install new PIMs on your mac to replace this bash script https://github.com/anaelChardan/AkeneoTools/tree/master/pim-installer

Feel free to give your ideas :-)

## Work in Progress

This tool is in progress, so for the moment it missing some views to configures your paths and your preferences

In order to get it working for the moment you must:

- Configure your settings
```
cp AkeneoMacApp/Settings.plist.dist AkeneoMacApp/Settings.plist
```
- Configure your port on `AkeneoMacApp/Docker/DockerService`
- Launch Docker
- Launch manually socat to expose the TCP port of docker 
```
brew install socat && socat TCP-LISTEN:2375,reuseaddr,fork,bind=localhost UNIX-CONNECT:/var/run/docker.sock
```

## Current status

![Current Status](/assets_doc/current_status.png)


Developed with :heart: by Anaël (Proud Akeneo Core Developer)