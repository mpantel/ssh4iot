require 'optparse'

class Parameter
  def self.parse(options)
    args = {}

    opt_parser = OptionParser.new do |opts|

      opts.banner = <<BANNER

Usage: #{File.basename($0)} [options]

Server:

Client:


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
      args[:port] = '1976'
      opts.on("-p", "--port=PORT", "Server hostname accessed as https://HOSTNAME") do |n|
        args[:host] = n
      end


      args[:directory] = "backup/backup_#{Time.now.strftime('%Y%m%dT%H%M%S')}"
      opts.on("-d", "--directory=BACKUP_DIRECTORY", "Backup") do |n|
        args[:directory] = n
      end
      opts.on("-r", "--restore", "Restore") do |n|
        args[:restore] = n
      end
      opts.on("--review", "Review backup/restore actions") do |n|
        args[:review] = n
      end
      opts.on("--details", "Review backup/restore actions with commands to be executed") do |n|
        args[:details] = n
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args.merge({containers: ARGV})
  rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e

    puts ["\nError:\n------\n", e.message, "\n------\n"]
    opt_parser.parse!(['-h'])

  end
end