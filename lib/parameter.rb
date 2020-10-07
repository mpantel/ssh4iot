require 'optparse'

class Parameter
  def self.parse(options)
    args = {}

    opt_parser = OptionParser.new do |opts|

      opts.banner = <<BANNER

Usage: #{File.basename($0)} [options]

Server:

starts docker ssh server and awaits connections

Client:

generate reverse proxy

BANNER

      opts.on("-s", "--server", "Server Operation") do |n|
        args[:server] = n
      end
      opts.on("-c", "--client", "Client Operation") do |n|
        args[:client] = n
      end
      opts.on("--cron-setup", "Register as cron job") do |n|
        args[:cron_setup] = n
      end
      opts.on("--cron-cleanup", "Unregister as cron job") do |n|
        args[:cron_cleanup] = n
      end

      args[:host] = 'localhost'
      opts.on("--host=HOSTNAME", "Server hostname accessed as https://HOSTNAME") do |n|
        args[:host] = n
      end
      opts.on("--user=USER", "Connect to Server as USER") do |n|
        args[:host] = n
      end
      args[:port] = '2020'
      opts.on("-p", "--port=PORT", "Server port for ssh") do |n|
        args[:port] = n
      end

      args[:container] = 'ssh4iot'
      opts.on("--container=CONTAINER",  "Docker container") do |n|
        args[:container] = n
      end
      opts.on("--list",  "list registered") do |n|
        args[:list] = n
      end
      opts.on("--authorize",  "Authorize request") do |n|
        args[:authorize] = n
      end

      opts.on("--register",  "Request autorization") do |n|
        args[:register] = n
      end
      opts.on("--unregister",  "Request autorization") do |n|
        args[:unregister] = n
        end

      opts.on("--connect",  "initiate remote proxy") do |n|
        args[:connect] = n
      end
      opts.on("--ping",  "initiate remote proxy") do |n|
        args[:ping] = n
      end
      args[:range] = "10000:11000"
      opts.on("--range=RANGE",  "initiate remote proxy") do |n|
        args[:range] = n
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    lower,upper = args[:range].split(":")
    return args.merge(Hash[["lower","upper"].zip( args[:range].split(":").sort)]).merge({subject: ARGV}) # ssh users
  rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e

    puts ["\nError:\n------\n", e.message, "\n------\n"]
    opt_parser.parse!(['-h'])

  end
end