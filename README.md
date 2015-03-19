# Personal Vagrant Setup for HMRC Project

Files that help set up a ubuntu scala dev box

## Setup WinNFSd

Manage and adds support for NFS on windows.
Supported guests:

  * Linux

### Installation

```
$ vagrant plugin install vagrant-winnfsd
```

### Activate NFS for vagrant

To activate NFS for vagrant see: http://docs.vagrantup.com/v2/synced-folders/nfs.html

The plugin extends vagrant in the way that you can use NFS also with windows. So the following hint on the vagrant documentation page is no longer true:

```
Windows users: NFS folders do not work on Windows hosts. Vagrant will ignore your request for NFS synced folders on Windows.
```

You will also need to declare some sort of network in order for NFS to work (the Virtualbox implied network will not work). Luckily this is easily done by adding the following line to your Vagrantfile:

```ruby
# A private dhcp network is required for NFS to work (on Windows hosts, at least)
config.vm.network "private_network", type: "dhcp"
```

### Settings

#### Logging

You activate the logging of the nfs daemon which will show the daemon window in the foreground. To activate the logging set the `config.winnfsd.logging` to `on`.

#### Set uid and gid

You can set the uid via the `config.winnfsd.uid` param and the gid via the `config.winnfsd.gid` param. Example:

```ruby
Vagrant.configure('2') do |config|
    config.winnfsd.uid = 1
    config.winnfsd.gid = 1
end
```

Note that will be set global, that means the uid and gid is taken from the first box which starts the nfs daemon. If a box with an other uid or gid is started after that the option will be ignored.
