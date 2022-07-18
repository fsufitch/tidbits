Development VM
==============

This is documentation of my attempt to set up a developer-friendly VM for isolating Docker-related work.

The motivation is the security/performance/cost concerns that Docker Desktop causes at my job. In addition, a dev VM has other benefits.
I develop on a MacOS machine, and this presents some challenges/hiccups:

* Docker Desktop creates multiple issues.

  * Its daemon management tools are primitive and run into issues with performance.
  
  * Docker crashes/errors due to running out of resources (memory or disk usually) have very vague, unhelpful errors.
  
  * The Hyperkit VM is opaque, and has no oversight either from antimalware (because it's a VM) or from the developer themselves.
    This presents [serious security concerns](https://community.atlassian.com/t5/Trust-Security-articles/Hiding-malware-in-Docker-Desktop-s-virtual-machine/ba-p/1924743).
    
  * The VM has access to the whole host's home directory, including very sensitive stuff such as `~/.ssh`.

* CLI tools do not function as they do in production (or in Docker containers). 
  BSD `grep`/`sed`/`make` and other tools have subtle differences that become pitfalls when commands must be compatible with both BSD and GNU variants. 


### Objectives:

* Be a replacement for Docker Desktop / Hyperkit

* Steps are useable cross-OS

* OS in the VM is lightweight, stable, and supports the tools I need for development

  * Docker (required) and Podman (nice-to-have, for testing compatiblity)
  
  * SSH Server and Client, GPG, Git, Make, etc.
  
* Setup in general is compatible with a SSH "remote" development workflow (feature in VSCode and other IDEs)


Process
-------

# 1. Download/Install VM requirements

> https://linuxconfig.org/how-to-create-and-manage-kvm-virtual-machines-from-cli


    virt-install --name=docker-dev-vm \
        --vcpus=$(cat /proc/cpuinfo | grep processor | wc -l) \
        --memory=1024 \
        --cdrom=/tmp/debian-9.0.0-amd64-netinst.iso \
        --disk size=5 \
        --os-variant=debian8

    brew install libvirt ??
    brew install 



* virt-manager

* QEMU

  * On Linux: `sudo apt install qemu-system-x86 qemu-system qemu-utils`

* CentOS Stream ISO

  * `curl -LO 'https://mirrors.centos.org/mirrorlist?path=/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-dvd1.iso&redirect=1&protocol=https'`
  
  * Rename to `centos.iso`





