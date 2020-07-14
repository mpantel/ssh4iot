# ssh4iot
Easy way to configure and register reverse ssh tunnels for iot devices by keysharing over https to manage and enjoy

# Intoduction

When deploying several iot devices on a private network and there is a need to manage them centrally for updates and administration. While the most appropriate way of interacting with these devices is through ssh connections there are many conciderations when the number of appliances grows beyond a couple of devices. More over  we need to group these appliances into groups based on some organizational criteria namelly to split up administration. We aim at minimizing the setup needs for the appliances to:

1. the server address
2. one shared api token per deployment group for the initial setup
3. one identifier per device

# Architecture

- Server:
1. Web application/administration
2. Repository
3. one user per deployment group
4. ssh server

- Client:
1. Client application
2. one user per client device
3. autossh

# Considerations

1. initial setup
2. networking and wifi registration
3. security

# Implementation

# Case Study

Given a deployment which uses many Raspberry Pi's with SenseHat to collect environmental measuremements from an number of buildings, storing them in a central data base, we need an easy way to register and manage devices

# References
https://xtermjs.org/
https://github.com/huashengdun/webssh
https://github.com/stuicey/SSHy

https://www.rubydoc.info/github/net-ssh/net-ssh/Net/SSH
https://net-ssh.github.io/net-ssh/


