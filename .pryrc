require 'rubygems'
require 'awesome_print'
require 'table_print'

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = '~/.pry-history'

AwesomePrint.pry!

def y(obj)
  puts obj.to_yaml
end

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

Pry.config.exception_handler = proc do |output, exception, _pry_|
  output.puts "#{exception}"
  exception.backtrace.each { |eb| puts eb }
end
