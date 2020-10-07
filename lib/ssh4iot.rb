require "ssh4iot/version"
require "parameter"

require 'rake'
require 'rake/file_utils_ext'

require 'net/ssh'
require 'logger'

module Ssh4iot
  class Error < StandardError; end

  parameters = Parameter.parse(ARGV)
  pp parameters if parameters[:review]

  def clear_docker
    sh "docker rm -f #{params['container']}"
  end
  def start_server
    sh "docker build -t #{params['container']} . && docker run -d --restart unless-stopped -v ~/ssh4iot:/home --expose 80 -p #{parameters['port']}:22 -it --name #{params['container']} --label traefik.backend=ssh4iot --label traefik.frontend.rule=\"Host:#{parameters['host']};PathPrefixStrip:/ssh4iot\" --label traefik.frontend.entryPoints=http,https #{params['container']} sh"
  end

  def remove_user(user)
    sh "deluser --remove-home #{user}"
  end
  def add_user(user)
    sh "useradd #{user} && mkdir /home/#{user} && chown -R #{user}#{user} /home/#{user}"
  end

  def keygen
    sh "ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -N ''"
  end
  def register_key
    sh "cat ~/.ssh/id_rsa.pub | ssh demo@198.51.100.0 \"mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys\""
  end

  def reverse_proxy(port,key_path)
    # https://www.rubydoc.info/github/net-ssh/net-ssh/Net/SSH
    # https://net-ssh.github.io/ssh/v1/chapter-3.html#s2

    Net::SSH.start(
        parameters['host'], parameters['user'],
        :keys => [ key_path ],
    #:compression => "zlib"
    ) do |session|
      session.forward.remote(params["port"],  parameters['host'], port)
      session.loop { true }
    end

  end

end



__END__
X == “execute a command and capture the output”

Net::SSH.start("host", "user", password: "password") do |ssh|
  result = ssh.exec!("ls -l")
  puts result
end

X == “forward connections on a local port to a remote host”

Net::SSH.start("host", "user", password: "password") do |ssh|
  ssh.forward.local(1234, "www.google.com", 80)
  ssh.loop { true }
end

X == “forward connections on a remote port to the local host”

Net::SSH.start("host", "user", password: "password") do |ssh|
  ssh.forward.remote(80, "www.google.com", 1234)
  ssh.loop { true }
end
