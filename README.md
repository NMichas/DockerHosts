# DockerHosts
A handy shell utility to find the IP address of a docker-machine and add a default entry
in your `hosts` file. The name of the entry to be added is `docker-machine-{name}`, e.g
`docker-machine-default`,  `docker-machine-dev`, `docker-machine-test`, etc.

## Usage
- `sudo ./docker-hosts.sh`  
Will look into `/etc/hosts` for an entry `docker-machine-default` and update
its IP address (or add it if it does not exist).
- `sudo ./docker-hosts.sh dev`  
Will look into `/etc/hosts` for an entry `docker-machine-dev` and update
its IP address (or add it if it does not exist).

## Notes
- The IP address of the docker-machine is found using the `docker-machine ip`
command, so you should have `docker-machine` accessible in your path.
- In case the `docker-machine ip` command returns with an exit level other than 0
(i.e. something went wrong while trying to find the IP address of the docker-machine
you specified) nothing is changed in your `hosts` file.

## Sample output
    nassos@nmichas:~/$ sudo ./docker-hosts.sh
    Using docker machine: "default"
    IP address: "172.16.36.212"
    /etc/hosts: 172.16.36.212 docker-machine-default

    nassos@nmichas:~/$ sudo ./docker-hosts.sh invalid-name
    Using docker machine: "invalid-name"
    Host does not exist: "invalid-name"
