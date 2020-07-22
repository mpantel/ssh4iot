1 login to server
2 add team user (no password)
  adduser team_username
3 create key pair
    https://www.linuxbabe.com/linux-server/setup-passwordless-ssh-login
    a. create
        ssh-keygen -t rsa -b 4096
    b. copy id to each team member as team member username (pi)
        ssh-copy-id pi@team.member
    
4 for each team member
  1 install autoshh (https://www.everythingcli.org/ssh-tunnelling-for-fun-and-profit-autossh/)
  sudo apt-get install autossh
  2 create key pair
    a. ssh-keygen -t rsa -b 4096
    
    b. copy id to server as team_username
    ssh-copy-id team_user@server
  3 setup reverse tunel (https://handyman.dulare.com/ssh-tunneling-with-autossh/)
  
  create file 
  mkdir -p ~/.local/share/systemd/user
  vi ~/.local/share/systemd/user/reverse_ssh.service
  # set a  uniq port for each other like 2222 
  [Unit]
Description=AutoSSH tunnel service for remote port 10003 to local 22
After=network.target
[Service]
Environment="AUTOSSH_GATETIME=0"
ExecStart=/usr/bin/autossh -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -N -R 10003:localhost:22 terriade@psmart.aegean.gr
[Install]
WantedBy=multi-user.target
  
  start service as pi user
  https://superuser.com/questions/1215631/how-to-run-systemctl-service-as-user

systemctl --user daemon-reload
systemctl --user start  reverse_ssh.service 
systemctl --user enable  reverse_ssh.service 
systemctl --user status  reverse_ssh.service   
sudo netstat -ntlp | grep LISTEN

then:

ssh pi@127.0.0.1 -p 2222

  
